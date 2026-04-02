//
//  HealthTypes.swift
//  LabWeek6
//
//  Created by student on 02/04/26.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable {
    case lakiLaki = "Laki-laki"
    case perempuan = "Perempuan"

    var id: String { rawValue }

    var bmrConstant: Double {
        switch self {
        case .lakiLaki:
            return 5
        case .perempuan:
            return -161
        }
    }
}

enum WeightUnit: String, CaseIterable, Identifiable {
    case kg = "kg"
    case lbs = "lbs"

    var id: String { rawValue }

    func toKilograms(_ value: Double) -> Double {
        switch self {
        case .kg:
            return value
        case .lbs:
            return value * 0.45359237
        }
    }
}

enum HeightUnit: String, CaseIterable, Identifiable {
    case cm = "cm"
    case m = "m"
    case inch = "in"

    var id: String { rawValue }

    func toCentimeters(_ value: Double) -> Double {
        switch self {
        case .cm:
            return value
        case .m:
            return value * 100
        case .inch:
            return value * 2.54
        }
    }

    func toMeters(_ value: Double) -> Double {
        toCentimeters(value) / 100
    }
}
