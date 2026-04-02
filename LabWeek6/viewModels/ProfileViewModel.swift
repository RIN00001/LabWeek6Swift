//
//  ProfileViewModel.swift
//  LabWeek6
//
//  Created by student on 02/04/26.
//

import Foundation
import Combine

final class ProfileViewModel: ObservableObject {
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

    var user: User {
        data.user
    }

    var dailyStreak: Int {
        data.dailyStreak
    }

    var isDarkMode: Bool {
        get { data.isDarkMode }
        set { data.isDarkMode = newValue }
    }

    func increaseStreak() {
        data.increaseStreak()
    }

    func resetStreak() {
        data.resetStreak()
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
        data.updateUser(
            name: name,
            age: age,
            gender: gender,
            weightValue: weightValue,
            weightUnit: weightUnit,
            heightValue: heightValue,
            heightUnit: heightUnit
        )
    }
}
