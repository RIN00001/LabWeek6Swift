//
//  FoodLogEntry.swift
//  LabWeek6
//
//  Created by student on 02/04/26.
//

import Foundation

struct FoodLogEntry: Identifiable, Hashable {
    let id: UUID
    var foodName: String
    var calories: Int
    var date: Date
    var imageData: Data?

    init(
        id: UUID = UUID(),
        foodName: String,
        calories: Int,
        date: Date,
        imageData: Data? = nil
    ) {
        self.id = id
        self.foodName = foodName
        self.calories = calories
        self.date = date
        self.imageData = imageData
    }
}

struct DailyCalorieSummary: Identifiable {
    var id: Date { date }

    let date: Date
    let totalCalories: Int
    let entryCount: Int
}
