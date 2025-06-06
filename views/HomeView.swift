import SwiftUI

struct HomeView: View {
    @State var user: User
    @StateObject var locationManager = LocationManager()
    @State private var professionals: [User] = [
        User(id: "1", name: "Alice", email: nil, phone: "1234567890", profilePhotoData: nil, location: "Paris", country: "France", latitude: 48.8566, longitude: 2.3522, profession: "Mechanic", bio: "Expert in car repairs", experience: "10 years", availability: .available, availableFrom: nil, availableTo: nil, rating: 4.5, ratingCount: 12, isProfessional: true, barcodeString: "ALICE1234567890", cardBackgroundColorHex: "#008080", cardAccentColorHex: "#0000FF", cardFontName: "AvenirNext-Bold"),
        User(id: "2", name: "Bob", email: nil, phone: "0987654321", profilePhotoData: nil, location: "Versailles", country: "France", latitude: 48.8049, longitude: 2.1204, profession: "Plumber", bio: "Fast and reliable", experience: "5 years", availability: .busy, availableFrom: nil, availableTo: nil, rating: 4.0, ratingCount: 8, isProfessional: true, barcodeString: "BOB0987654321", cardBackgroundColorHex: "#008080", cardAccentColorHex: "#0000FF", cardFontName: "AvenirNext-Bold")
    ]
    @State private var showProfile = false

    var body: some View {
        NavigationView {
            VStack {
                Button("Edit My Profile") {
                    showProfile = true
                }
                .padding(.bottom)
                Text("Welcome, \(user.name)!")
                    .font(.title)
                ProfessionalListView(professionals: $professionals, userLocation: locationManager.location) { selectedProfessional in
                    // Navigation to chat or details can be handled here
                }
                MapView(user: user, professionals: professionals, userLocation: locationManager.location)
                    .frame(height: 300)
            }
            .navigationTitle("Hubris")
            .sheet(isPresented: $showProfile) {
                ProfileEditView(user: $user)
            }
        }
    }
}
