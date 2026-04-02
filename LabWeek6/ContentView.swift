//
//  ContentView.swift
//  LabWeek6
//
//  Created by student on 02/04/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainTab()
    }
}

private struct PreviewContainer: View {
    @StateObject private var logBookViewModel: LogBookViewModel
    @StateObject private var profileViewModel: ProfileViewModel

    init() {
        let sharedData = AppData()
        sharedData.loadDummyData()
        
        _logBookViewModel = StateObject(wrappedValue: LogBookViewModel(data: sharedData))
        _profileViewModel = StateObject(wrappedValue: ProfileViewModel(data: sharedData))
    }

    var body: some View {
        ContentView()
            .environmentObject(logBookViewModel)
            .environmentObject(profileViewModel)
            .preferredColorScheme(profileViewModel.isDarkMode ? .dark : .light)
    }
}

#Preview("Interactive Theme Preview") {
    PreviewContainer()
}
