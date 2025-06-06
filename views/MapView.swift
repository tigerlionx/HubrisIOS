//
//  Untitled.swift
//  Hubris 2
//
//  Created by Emmanuel Leveille on 6/2/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    let user: User
    let professionals: [User]
    let userLocation: CLLocation?

    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )

    var body: some View {
        Map(position: $cameraPosition) {
            ForEach(professionalsWithLocation) { prof in
                Annotation(prof.name, coordinate: CLLocationCoordinate2D(latitude: prof.latitude!, longitude: prof.longitude!)) {
                    VStack {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title)
                        Text(prof.name)
                            .font(.caption)
                    }
                }
            }
        }
        .onAppear {
            if let loc = userLocation {
                cameraPosition = .region(
                    MKCoordinateRegion(
                        center: loc.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                    )
                )
            } else if let lat = user.latitude, let lon = user.longitude {
                cameraPosition = .region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: lat, longitude: lon),
                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                    )
                )
            }
        }
    }

    var professionalsWithLocation: [User] {
        professionals.filter { $0.latitude != nil && $0.longitude != nil }
    }
}
