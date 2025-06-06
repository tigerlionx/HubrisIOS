//
//  IDCardView.swift
//  Hubris 2
//
//  Created by Emmanuel Leveille on 6/2/25.
//

import SwiftUI

struct IDCardView: View {
    let user: User

    var body: some View {
        VStack(spacing: 24) {
            // Profile Photo
            if let data = user.profilePhotoData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color(hex: user.cardAccentColorHex), lineWidth: 3))
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .foregroundColor(.gray)
            }

            // Name and Profession
            Text(user.name)
                .font(.title)
                .fontWeight(.bold)
            if let profession = user.profession, !profession.isEmpty {
                Text(profession)
                    .font(.headline)
                    .foregroundColor(.secondary)
            }

            // Bio
            if let bio = user.bio, !bio.isEmpty {
                Text(bio)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            // Barcode as User Identifier
            VStack(spacing: 8) {
                if let barcode = BarcodeGenerator.generateBarcode(from: user.barcodeString) {
                    Image(uiImage: barcode)
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(height: 60)
                        .padding(.vertical, 4)
                }
                Text("My Hubris ID")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(user.barcodeString)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .truncationMode(.middle)
            }
            .padding(.top, 16)

            // Optional: Edit Button
            // NavigationLink("Edit Profile", destination: ProfileEditView(user: ...))

            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .navigationTitle("Profile")
    }
}
