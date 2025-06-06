//
//  RatingView.swift
//  Hubris 2
//
//  Created by Emmanuel Leveille on 6/2/25.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int

    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .onTapGesture { rating = star }
            }
        }
    }
}
