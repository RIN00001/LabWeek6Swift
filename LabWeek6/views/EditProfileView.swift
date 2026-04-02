//
//  EditProfileView.swift
//  LabWeek6
//
//  Created by student on 02/04/26.


import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject private var viewModel: ProfileViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var ageText = ""
    @State private var gender: Gender = .lakiLaki

    @State private var weightText = ""
    @State private var weightUnit: WeightUnit = .kg

    @State private var heightText = ""
    @State private var heightUnit: HeightUnit = .cm

    @State private var hasLoaded = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                topBar
                personalSection
                weightSection
                heightSection
            }
            .padding(.horizontal, 20)
            .padding(.top, 14)
            .padding(.bottom, 24)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarBackButtonHidden(true)
        .onAppear {
            loadUserOnce()
        }
    }

    private var topBar: some View {
        HStack {
            Button {
                saveAndDismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.headline.weight(.bold))
                    .foregroundStyle(.primary)
                    .frame(width: 38, height: 38)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
            }

            Spacer()

            Text("Edit Profil")
                .font(.headline)

            Spacer()

            Color.clear
                .frame(width: 38, height: 38)
        }
    }

    private var personalSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Data Pribadi")
                .font(.headline)

            VStack(spacing: 12) {
                TextField("Nama", text: $name)
                    .textFieldStyle(.roundedBorder)

                HStack {
                    TextField("Umur", text: $ageText)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)

                    Text("tahun")
                        .foregroundStyle(.secondary)
                }

                Picker("Gender", selection: $gender) {
                    ForEach(Gender.allCases) { item in
                        Text(item.rawValue).tag(item)
                    }
                }
                .pickerStyle(.menu)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.cardBackground)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.cardStroke.opacity(0.25), lineWidth: 1)
            )
        }
    }

    private var weightSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Berat Badan")
                .font(.headline)

            VStack(spacing: 12) {
                TextField("Berat badan", text: $weightText)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)

                Picker("Unit Berat", selection: $weightUnit) {
                    ForEach(WeightUnit.allCases) { unit in
                        Text(unit.rawValue).tag(unit)
                    }
                }
                .pickerStyle(.segmented)

                Text(weightStandardText)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.cardBackground)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.cardStroke.opacity(0.25), lineWidth: 1)
            )
        }
    }

    private var heightSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Tinggi Badan")
                .font(.headline)

            VStack(spacing: 12) {
                TextField("Tinggi badan", text: $heightText)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)

                Picker("Unit Tinggi", selection: $heightUnit) {
                    ForEach(HeightUnit.allCases) { unit in
                        Text(unit.rawValue).tag(unit)
                    }
                }
                .pickerStyle(.segmented)

                Text(heightStandardText)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.cardBackground)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.cardStroke.opacity(0.25), lineWidth: 1)
            )
        }
    }

    private var weightStandardText: String {
        let value = normalizedDouble(from: weightText) ?? 0
        guard value > 0 else { return "≈ 0.00 kg (standar)" }
        let kg = weightUnit.toKilograms(value)
        return String(format: "≈ %.2f kg (standar)", kg)
    }

    private var heightStandardText: String {
        let value = normalizedDouble(from: heightText) ?? 0
        guard value > 0 else { return "≈ 0.00 cm (standar)" }
        let cm = heightUnit.toCentimeters(value)
        return String(format: "≈ %.2f cm (standar)", cm)
    }

    private func loadUserOnce() {
        guard !hasLoaded else { return }
        hasLoaded = true

        let user = viewModel.user
        name = user.name
        ageText = user.age > 0 ? "\(user.age)" : ""
        gender = user.gender
        weightText = user.weightValue > 0 ? formattedInput(user.weightValue) : ""
        weightUnit = user.weightUnit
        heightText = user.heightValue > 0 ? formattedInput(user.heightValue) : ""
        heightUnit = user.heightUnit
    }

    private func saveAndDismiss() {
        let age = Int(ageText) ?? 0
        let weight = normalizedDouble(from: weightText) ?? 0
        let height = normalizedDouble(from: heightText) ?? 0

        viewModel.updateUser(
            name: name,
            age: age,
            gender: gender,
            weightValue: weight,
            weightUnit: weightUnit,
            heightValue: height,
            heightUnit: heightUnit
        )

        dismiss()
    }

    private func normalizedDouble(from text: String) -> Double? {
        Double(text.replacingOccurrences(of: ",", with: "."))
    }

    private func formattedInput(_ value: Double) -> String {
        if value.rounded() == value {
            return String(format: "%.0f", value)
        } else {
            return String(format: "%.2f", value)
        }
    }
}
