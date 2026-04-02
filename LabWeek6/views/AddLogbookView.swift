//
//  AddLogbookView.swift
//  LabWeek6
//
//  Created by student on 02/04/26.
//


import SwiftUI
import PhotosUI

struct AddLogbookView: View {
    @EnvironmentObject private var viewModel: LogBookViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var foodName = ""
    @State private var calorieText = ""
    @State private var selectedDate = Date()

    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var selectedImageData: Data?

    private var canSave: Bool {
        let trimmedName = foodName.trimmingCharacters(in: .whitespacesAndNewlines)
        let calories = Int(calorieText) ?? 0
        return !trimmedName.isEmpty && calories > 0
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                topBar
                photoSection
                infoSection
                dateSection
            }
            .padding(.horizontal, 20)
            .padding(.top, 14)
            .padding(.bottom, 24)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .task(id: selectedPhotoItem) {
            await loadSelectedPhoto()
        }
    }

    private var topBar: some View {
        HStack {
            Button("Batal") {
                dismiss()
            }
            .foregroundStyle(.primary)

            Spacer()

            Text("Tambah Makanan")
                .font(.headline)

            Spacer()

            Button("Simpan") {
                saveLogbook()
            }
            .fontWeight(.semibold)
            .foregroundStyle(canSave ? Color.primary : Color.secondary)
            .disabled(!canSave)
        }
    }

    private var photoSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Foto Makanan")
                .font(.headline)

            VStack(alignment: .leading, spacing: 12) {
                if let imageData = selectedImageData,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                    Button("Hapus Foto") {
                        selectedPhotoItem = nil
                        selectedImageData = nil
                    }
                    .foregroundStyle(.red)
                }

                PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                    Label(
                        selectedImageData == nil ? "Pilih Foto" : "Ganti Foto",
                        systemImage: "photo"
                    )
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.blue)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(.systemBackground))
            )
        }
    }

    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Info Makanan")
                .font(.headline)

            VStack(spacing: 12) {
                TextField("Nama Makanan", text: $foodName)
                    .textFieldStyle(.roundedBorder)

                HStack {
                    TextField("Kalori", text: $calorieText)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)

                    Text("kcal")
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(.systemBackground))
            )
        }
    }

    private var dateSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Tanggal")
                .font(.headline)

            DatePicker(
                "",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .labelsHidden()
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(.systemBackground))
            )
        }
    }

    private func saveLogbook() {
        let trimmedName = foodName.trimmingCharacters(in: .whitespacesAndNewlines)
        let calories = Int(calorieText) ?? 0

        guard !trimmedName.isEmpty, calories > 0 else { return }

        viewModel.addFoodLog(
            foodName: trimmedName,
            calories: calories,
            date: selectedDate,
            imageData: selectedImageData
        )

        dismiss()
    }

    private func loadSelectedPhoto() async {
        guard let selectedPhotoItem else { return }
        selectedImageData = try? await selectedPhotoItem.loadTransferable(type: Data.self)
    }
}
