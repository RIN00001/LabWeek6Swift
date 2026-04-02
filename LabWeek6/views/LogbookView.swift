//
//  LogbookView.swift
//  LabWeek6
//
//  Created by student on 02/04/26.
//


import SwiftUI

struct LogbookView: View {
    @EnvironmentObject private var viewModel: LogBookViewModel
    @State private var showAddLogbook = false

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    }()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                headerSection
                greetingSection
                summarySection
                foodEntriesSection
            }
            .padding(.horizontal, 20)
            .padding(.top, 18)
            .padding(.bottom, 24)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .navigationBar)
        .fullScreenCover(isPresented: $showAddLogbook) {
            AddLogbookView()
                .environmentObject(viewModel)
        }
    }

    private var headerSection: some View {
        HStack {
            Text("Logbook Makanan")
                .font(.largeTitle.bold())

            Spacer()

            Button {
                showAddLogbook = true
            } label: {
                Image(systemName: "plus")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(.primary)
                    .frame(width: 42, height: 42)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
            }
        }
    }

    private var greetingSection: some View {
        Text(viewModel.greetingText)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
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

    @ViewBuilder
    private var summarySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Ringkasan Kalori Harian")
                .font(.headline)

            if viewModel.dailySummaries.isEmpty {
                Text("Belum ada data logbook.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            } else {
                VStack(spacing: 10) {
                    HStack {
                        Text("Tanggal")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("Total")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("Entri")
                            .foregroundStyle(.secondary)
                    }
                    .font(.caption)
                    .fontWeight(.semibold)

                    ForEach(viewModel.dailySummaries) { summary in
                        HStack {
                            Text(dateFormatter.string(from: summary.date))
                            Spacer()
                            Text("\(summary.totalCalories) kcal")
                            Spacer()
                            Text("\(summary.entryCount)")
                        }
                        .font(.subheadline)
                    }

                    Divider()

                    HStack {
                        Text("Rata-rata / hari")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(viewModel.averageCaloriesText)
                            .fontWeight(.semibold)
                    }
                    .font(.subheadline)
                }
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

    @ViewBuilder
    private var foodEntriesSection: some View {
        if viewModel.groupedFoodLogs.isEmpty {
            Text("Belum ada makanan tercatat. Tekan + untuk mulai.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color(.systemBackground))
                )
        } else {
            VStack(alignment: .leading, spacing: 18) {
                ForEach(viewModel.groupedFoodLogs, id: \.date) { group in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(dateFormatter.string(from: group.date))
                            .font(.headline)
                            .padding(.leading, 2)

                        ForEach(group.entries) { entry in
                            FoodLog_Card(entry: entry) {
                                viewModel.deleteFoodLog(entry)
                            }
                        }
                    }
                }
            }
        }
    }
}
 

