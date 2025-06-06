//
//  ProfileEditView.swift
//  Hubris 2
//
//  Created by Emmanuel Leveille on 6/2/25.
//

import SwiftUI

struct ProfileEditView: View {
    @Binding var user: User
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    @State private var profileImage: Image?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Photo")) {
                    VStack {
                        if let profileImage = profileImage {
                            profileImage
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.crop.circle.badge.plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .foregroundColor(.gray)
                        }
                        Button("Upload Photo") {
                            showImagePicker = true
                        }
                    }
                }
                Section(header: Text("Professional Info")) {
                    TextField("Profession", text: Binding($user.profession, replacingNilWith: ""))
                    TextField("Bio", text: Binding($user.bio, replacingNilWith: ""))
                    TextField("Experience", text: Binding($user.experience, replacingNilWith: ""))
                }
                Section(header: Text("Location")) {
                    TextField("Town/City", text: Binding($user.location, replacingNilWith: ""))
                    TextField("Country", text: Binding($user.country, replacingNilWith: ""))
                }
                Button("Save") {
                    if let inputImage = inputImage {
                        user.profilePhotoData = inputImage.jpegData(compressionQuality: 0.8)
                    }
                    // You can add navigation to HomeView here
                }
            }
            .navigationTitle("Edit Profile")
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        profileImage = Image(uiImage: inputImage)
    }
}

// Helper for optional binding
extension Binding {
    init(_ source: Binding<Value?>, replacingNilWith defaultValue: Value) {
        self.init(
            get: { source.wrappedValue ?? defaultValue },
            set: { source.wrappedValue = $0 }
        )
    }
}
