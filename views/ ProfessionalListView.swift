//
//   ProfessionalListView.swift
//  Hubris 2
//
//  Created by Emmanuel Leveille on 6/2/25.
//

import SwiftUI
import CoreLocation

struct ProfessionalListView: View {
    @State private var searchQuery = ""
    @Binding var professionals: [User]
    var userLocation: CLLocation?
    @State private var searchRadius: Double = 3.0
    @State private var filterByTown = ""
    @State private var filterByCountry = ""
    var onSelect: (User) -> Void

    func distance(from: CLLocation, to: CLLocation) -> Double {
        from.distance(from: to) / 1000
    }

    var filteredProfessionals: [User] {
        professionals.filter { prof in
            guard prof.isProfessional else { return false }
            let matchesProfession = searchQuery.isEmpty || (prof.profession?.localizedCaseInsensitiveContains(searchQuery) ?? false)
            let matchesTown = filterByTown.isEmpty || (prof.location?.localizedCaseInsensitiveContains(filterByTown) ?? false)
            let matchesCountry = filterByCountry.isEmpty || (prof.country?.localizedCaseInsensitiveContains(filterByCountry) ?? false)
            var matchesDistance = true
            if let userLoc = userLocation, let lat = prof.latitude, let lon = prof.longitude {
                let profLoc = CLLocation(latitude: lat, longitude: lon)
                let dist = distance(from: userLoc, to: profLoc)
                matchesDistance = searchRadius == 0 || dist <= searchRadius
            }
            return matchesProfession && matchesTown && matchesCountry && matchesDistance
        }
    }

    var body: some View {
        VStack {
            TextField("Search for a profession (e.g., mechanic)", text: $searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack {
                Text("Radius: \(searchRadius == 0 ? "No limit" : String(format: "%.1f km", searchRadius))")
                Slider(value: $searchRadius, in: 0...50, step: 0.5)
                Button("∞") { searchRadius = 0 }
            }
            .padding(.vertical)
            HStack {
                TextField("Town", text: $filterByTown)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Country", text: $filterByCountry)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.bottom)
            List(filteredProfessionals) { prof in
                Button(action: { onSelect(prof) }) {
                    VStack(alignment: .leading) {
                        Text(prof.name)
                            .font(.headline)
                        Text(prof.profession ?? "")
                            .font(.subheadline)
                        if let rating = prof.rating {
                            RatingView(rating: .constant(Int(rating)))
                        }
                        if let lat = prof.latitude, let lon = prof.longitude, let userLoc = userLocation {
                            let dist = distance(from: userLoc, to: CLLocation(latitude: lat, longitude: lon))
                            Text(String(format: "Distance: %.2f km", dist))
                                .font(.caption)
                        }
                        Text("Status: \(prof.availability.rawValue)")
                            .font(.caption)
                    }
                }
            }
        }
        .navigationTitle("Find Professionals")
        .padding()
    }
}
