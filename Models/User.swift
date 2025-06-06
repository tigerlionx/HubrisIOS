//
//  User.swift
//  Hubris 2
//
//  Created by Emmanuel Leveille on 6/1/25.
//
import Foundation

struct User: Identifiable, Codable {
    var id: String
    var name: String
    var email: String?
    var phone: String?
    var profilePhotoData: Data?
    var location: String?
    var country: String?
    var latitude: Double?
    var longitude: Double?
    var profession: String?
    var bio: String?
    var experience: String?
    var availability: AvailabilityStatus
    var availableFrom: Date?
    var availableTo: Date?
    var rating: Double?
    var ratingCount: Int?
    var isProfessional: Bool
    var barcodeString: String
    var cardBackgroundColorHex: String
    var cardAccentColorHex: String
    var cardFontName: String
}
