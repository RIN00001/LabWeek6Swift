//
//  LabWeek6App.swift
//  LabWeek6
//
//  Created by student on 02/04/26.
//

import SwiftUI

@main
struct LabWeek6App: App {
    @StateObject private var logBookViewModel: LogBookViewModel
    @StateObject private var profileViewModel: ProfileViewModel

    init() {
        let sharedData = AppData()
        _logBookViewModel = StateObject(wrappedValue: LogBookViewModel(data: sharedData))
        _profileViewModel = StateObject(wrappedValue: ProfileViewModel(data: sharedData))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(logBookViewModel)
                .environmentObject(profileViewModel)
                .environment(\.locale, Locale(identifier: "id_ID"))
        }
    }
}
