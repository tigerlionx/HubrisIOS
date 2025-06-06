//
//  Untitled.swift
//  Hubris 2
//
//  Created by Emmanuel Leveille on 6/2/25.
//

import Foundation

enum AvailabilityStatus: String, Codable, CaseIterable {
    case available = "Available"
    case availableBetween = "Available Between"
    case busy = "Busy"
    case onTheWay = "On The Way"
    case concluded = "Concluded"
}
