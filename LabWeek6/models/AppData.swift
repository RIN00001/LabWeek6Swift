//
//  AppData.swift
//  LabWeek6
//
//  Created by student on 02/04/26.
//

import Foundation
import SwiftUI
import Combine

final class AppData: ObservableObject {
    @Published var user = User()
    @Published var foodLogs: [FoodLogEntry] = []
    @Published var dailyStreak: Int = 0
    @Published var isDarkMode: Bool = false

    private let calendar = Calendar.current

    var greetingText: String {
        "Hi, \(user.displayName)!"
    }

    var sortedFoodLogs: [FoodLogEntry] {
        foodLogs.sorted { $0.date > $1.date }
    }

    var groupedFoodLogs: [(date: Date, entries: [FoodLogEntry])] {
        let grouped = Dictionary(grouping: sortedFoodLogs) { entry in
            calendar.startOfDay(for: entry.date)
        }

        return grouped
            .map { (date: $0.key, entries: $0.value.sorted { $0.date > $1.date }) }
            .sorted { $0.date > $1.date }
    }

    var dailySummaries: [DailyCalorieSummary] {
        groupedFoodLogs.map { group in
            DailyCalorieSummary(
                date: group.date,
                totalCalories: group.entries.reduce(0) { $0 + $1.calories },
                entryCount: group.entries.count
            )
        }
    }

    var averageCaloriesPerDay: Double {
        guard !dailySummaries.isEmpty else { return 0 }
        let total = dailySummaries.reduce(0) { $0 + $1.totalCalories }
        return Double(total) / Double(dailySummaries.count)
    }

    var averageCaloriesText: String {
        guard !dailySummaries.isEmpty else { return "-" }
        return String(format: "%.0f kcal", averageCaloriesPerDay)
    }

    func addFoodLog(
        foodName: String,
        calories: Int,
        date: Date,
        imageData: Data?
    ) {
        let trimmedName = foodName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty, calories > 0 else { return }

        let newEntry = FoodLogEntry(
            foodName: trimmedName,
            calories: calories,
            date: date,
            imageData: imageData
        )

        foodLogs.append(newEntry)
    }

    func deleteFoodLog(_ entry: FoodLogEntry) {
        foodLogs.removeAll { $0.id == entry.id }
    }

    func increaseStreak() {
        dailyStreak += 1
    }

    func resetStreak() {
        dailyStreak = 0
    }

    func updateUser(
        name: String,
        age: Int,
        gender: Gender,
        weightValue: Double,
        weightUnit: WeightUnit,
        heightValue: Double,
        heightUnit: HeightUnit
    ) {
        user.name = name
        user.age = age
        user.gender = gender
        user.weightValue = weightValue
        user.weightUnit = weightUnit
        user.heightValue = heightValue
        user.heightUnit = heightUnit
    }
    
    func loadDummyData() {
        let calendar = Calendar.current
        let now = Date()

        dailyStreak = 3
        isDarkMode = false

        foodLogs = [
            FoodLogEntry(
                foodName: "Eggs",
                calories: 400,
                date: now,
                imageData: UIImage(named: "eggs")?.pngData()
            ),
            FoodLogEntry(
                foodName: "fruit",
                calories: 250,
                date: now,
                imageData: UIImage(named: "fruits")?.pngData()
            ),
            FoodLogEntry(
                foodName: "Lots of eggs",
                calories: 700,
                date: calendar.date(byAdding: .day, value: -1, to: now) ?? now,
                imageData: UIImage(named: "eggs2")?.pngData()            ),
            FoodLogEntry(
                foodName: "Sichuan Chili Oil Wontons",
                calories: 500,
                date: calendar.date(byAdding: .day, value: -2, to: now) ?? now,
                imageData: UIImage(named: "Sichuan Chili Oil Wontons")?.pngData()
            ),
            FoodLogEntry(
                foodName: "Tonkotsu Ramen",
                calories: 300,
                date: calendar.date(byAdding: .day, value: -5, to: now) ?? now,
                imageData: UIImage(named: "Tonkotsu Ramen")?.pngData()
            )
        ]
    }
}
