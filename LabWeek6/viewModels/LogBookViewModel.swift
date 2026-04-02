//
//  LogBookViewModel.swift
//  LabWeek6
//
//  Created by student on 02/04/26.
//

import Foundation
import Combine

final class LogBookViewModel: ObservableObject {
    private let data: AppData
    private var cancellables = Set<AnyCancellable>()

    init(data: AppData) {
        self.data = data

        data.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }

    var greetingText: String {
        data.greetingText
    }

    var groupedFoodLogs: [(date: Date, entries: [FoodLogEntry])] {
        data.groupedFoodLogs
    }

    var dailySummaries: [DailyCalorieSummary] {
        data.dailySummaries
    }

    var averageCaloriesText: String {
        data.averageCaloriesText
    }

    func addFoodLog(
        foodName: String,
        calories: Int,
        date: Date,
        imageData: Data?
    ) {
        data.addFoodLog(
            foodName: foodName,
            calories: calories,
            date: date,
            imageData: imageData
        )
    }

    func deleteFoodLog(_ entry: FoodLogEntry) {
        data.deleteFoodLog(entry)
    }
}
