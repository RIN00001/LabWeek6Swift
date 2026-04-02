//
//  MainTab.swift
//  LabWeek6
//
//  Created by student on 02/04/26.
//

import SwiftUI

enum AppTab {
    case logbook
    case profile
}

struct MainTab: View {
    @State private var selectedTab: AppTab = .logbook

    var body: some View {
        TabView {
            NavigationStack {
                LogbookView()
            }
            .tabItem {
                Label("Logbook", systemImage: "book.fill")
            }

            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person.fill")
            }
        }
    }

    private var bottomBar: some View {
        HStack(spacing: 12) {
            tabButton(
                title: "Logbook",
                systemImage: "book.fill",
                tab: .logbook
            )

            tabButton(
                title: "Profile",
                systemImage: "person.fill",
                tab: .profile
            )
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 26)
                .fill(.white)
                .shadow(color: .black.opacity(0.08), radius: 10, y: 3)
        )
        .padding(.horizontal, 20)
        .padding(.top, 8)
        .padding(.bottom, 12)
        .background(Color(.systemGroupedBackground))
    }

    private func tabButton(title: String, systemImage: String, tab: AppTab) -> some View {
        let isSelected = selectedTab == tab

        return Button {
            selectedTab = tab
        } label: {
            VStack(spacing: 6) {
                Image(systemName: systemImage)
                    .font(.system(size: 16, weight: .semibold))

                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .foregroundStyle(isSelected ? Color.blue : Color.primary.opacity(0.7))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(
                Capsule()
                    .fill(isSelected ? Color.blue.opacity(0.12) : Color.clear)
            )
        }
        .buttonStyle(.plain)
    }
}
