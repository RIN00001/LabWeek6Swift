//
//  User.swift
//  LabWeek6
//
//  Created by student on 02/04/26.
//

import Foundation

struct User {
    var name: String = ""
    var age: Int = 0
    var gender: Gender = .lakiLaki

    var weightValue: Double = 0
    var weightUnit: WeightUnit = .kg

    var heightValue: Double = 0
    var heightUnit: HeightUnit = .cm

    var trimmedName: String {
        name.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var displayName: String {
        trimmedName.isEmpty ? "..." : trimmedName
    }

    var weightInKg: Double {
        weightUnit.toKilograms(weightValue)
    }

    var heightInCm: Double {
        heightUnit.toCentimeters(heightValue)
    }

    var heightInM: Double {
        heightUnit.toMeters(heightValue)
    }

    var bmi: Double {
        guard weightInKg > 0, heightInM > 0 else { return 0 }
        return weightInKg / pow(heightInM, 2)
    }

    var bmiText: String {
        guard bmi > 0 else { return "-" }
        return String(format: "%.1f", bmi)
    }

    var bmiCategory: String {
        guard bmi > 0 else { return "Belum ada data" }

        switch bmi {
        case ..<18.5:
            return "Dibawah Standar"
        case 18.5..<25.0:
            return "Standar"
        case 25.0..<30.0:
            return "Sedikit Obesitas"
        default:
            return "Overweight"
        }
    }

    var bmr: Double {
        guard weightInKg > 0, heightInCm > 0, age > 0 else { return 0 }

        return (10 * weightInKg)
        + (6.25 * heightInCm)
        - (5 * Double(age))
        + gender.bmrConstant
    }

    var bmrText: String {
        guard bmr > 0 else { return "-" }
        return String(format: "%.0f kcal/hari", bmr)
    }

    var hasAnyData: Bool {
        !trimmedName.isEmpty ||
        age > 0 ||
        weightValue > 0 ||
        heightValue > 0
    }
}
