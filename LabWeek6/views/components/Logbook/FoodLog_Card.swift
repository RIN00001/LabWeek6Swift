//
//  FoodLog_Card.swift
//  LabWeek6
//
//  Created by student on 02/04/26.
//

import SwiftUI

struct FoodLog_Card: View {
    let entry: FoodLogEntry
    let onDelete: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            foodImage

            VStack(alignment: .leading, spacing: 4) {
                Text(entry.foodName)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text("\(entry.calories) kcal")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button("Hapus") {
                onDelete()
            }
            .font(.subheadline)
            .foregroundStyle(.red)
        }
        .padding(14)
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
    private var foodImage: some View {
        if let imageData = entry.imageData,
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: 62, height: 62)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        } else {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray5))
                .frame(width: 62, height: 62)
                .overlay {
                    Image(systemName: "photo")
                        .foregroundStyle(.secondary)
                }
        }
    }
}
