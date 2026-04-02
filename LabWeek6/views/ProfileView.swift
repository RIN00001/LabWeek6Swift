//
//  ProfileView.swift
//  LabWeek6
//
//  Created by student on 02/04/26.

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var viewModel: ProfileViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Text("Profil Saya")
                    .font(.largeTitle.bold())

                streakSection
                profileSummarySection
                bmiSection
                settingsSection
            }
            .padding(.horizontal, 20)
            .padding(.top, 18)
            .padding(.bottom, 24)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var streakSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Daily Streak")
                .font(.headline)

            VStack(spacing: 14) {
                HStack {
                    Text("Daily Streak")
                    Spacer()
                    Text("\(viewModel.dailyStreak) hari")
                        .foregroundStyle(.secondary)

                    Button {
                        viewModel.increaseStreak()
                    } label: {
                        Text("+1")
                            .font(.subheadline.weight(.bold))
                            .foregroundStyle(.blue)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.blue.opacity(0.12))
                            .clipShape(Capsule())
                    }
                }

                Button("Reset Streak") {
                    viewModel.resetStreak()
                }
                .foregroundStyle(.red)
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

    private var profileSummarySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Rangkuman Profil")
                .font(.headline)

            VStack(alignment: .leading, spacing: 12) {
                if viewModel.user.hasAnyData {
                    profileRow(title: "Nama", value: viewModel.user.displayName)
                    profileRow(title: "Umur", value: viewModel.user.age > 0 ? "\(viewModel.user.age) tahun" : "-")
                    profileRow(title: "Gender", value: viewModel.user.gender.rawValue)
                    profileRow(
                        title: "Berat",
                        value: viewModel.user.weightInKg > 0
                        ? String(format: "%.1f kg", viewModel.user.weightInKg)
                        : "-"
                    )
                    profileRow(
                        title: "Tinggi",
                        value: viewModel.user.heightInCm > 0
                        ? String(format: "%.1f cm", viewModel.user.heightInCm)
                        : "-"
                    )
                    profileRow(title: "Kebutuhan Kalori", value: viewModel.user.bmrText)
                } else {
                    Text("Belum ada data. Tekan Edit Profil untuk mengisi.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
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

    private var bmiSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("BMI")
                .font(.headline)

            VStack(spacing: 12) {
                profileRow(title: "Indeks Massa Tubuh", value: viewModel.user.bmiText)
                profileRow(title: "Kategori", value: viewModel.user.bmiCategory)
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

    private var settingsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Pengaturan")
                .font(.headline)

            VStack(spacing: 0) {
                NavigationLink {
                    EditProfileView()
                        .environmentObject(viewModel)
                } label: {
                    HStack {
                        Text("Edit Profil")
                            .foregroundStyle(.primary)

                        Spacer()

                        Image(systemName: "chevron.right")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 14)
                }

                Divider()

                HStack {
                    Text("Tema Gelap")
                    Spacer()
                    Toggle(
                        "",
                        isOn: Binding(
                            get: { viewModel.isDarkMode },
                            set: { newValue in
                                withAnimation {
                                    viewModel.isDarkMode = newValue
                                }
                            }
                        )
                    )
                    .labelsHidden()
                }
                .padding(.vertical, 14)
            }
            .padding(.horizontal, 16)
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

    private func profileRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
        }
        .font(.subheadline)
    }
}
