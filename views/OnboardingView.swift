//
//  Untitled.swift
//  Hubris 2
//
//  Created by Emmanuel Leveille on 6/1/25.
//
import SwiftUI

struct OnboardingView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var isProfessional = false
    @State private var showProfileEdit = false
    @State private var newUser: User? = nil

    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Phone", text: $phone)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Toggle("Are you a professional?", isOn: $isProfessional)
            Button("Continue") {
                let user = User(
                    id: UUID().uuidString,
                    name: name,
                    email: email.isEmpty ? nil : email,
                    phone: phone.isEmpty ? nil : phone,
                    profilePhotoData: nil,
                    location: nil,
                    country: nil,
                    latitude: nil,
                    longitude: nil,
                    profession: nil,
                    bio: nil,
                    experience: nil,
                    availability: .available,
                    availableFrom: nil,
                    availableTo: nil,
                    rating: nil,
                    ratingCount: nil,
                    isProfessional: isProfessional,
                    barcodeString: generateUniqueBarcodeString(email: email, phone: phone),
                    cardBackgroundColorHex: "#008080",
                    cardAccentColorHex: "#0000FF",
                    cardFontName: "AvenirNext-Bold"
                )
                newUser = user
                showProfileEdit = true
            }
            .disabled(name.isEmpty || (email.isEmpty && phone.isEmpty))
        }
        .padding()
        .fullScreenCover(isPresented: $showProfileEdit) {
            if let binding = Binding($newUser) {
                ProfileEditView(user: binding)
            }
        }
    }
}

func generateUniqueBarcodeString(email: String?, phone: String?) -> String {
    let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
    let base = (email ?? phone ?? "user") + deviceID
    return base
}
