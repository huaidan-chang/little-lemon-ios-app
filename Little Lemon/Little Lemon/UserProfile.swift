//
//  UserProfile.swift
//  Little Lemon
//
//  Created by dana chang on 7/9/24.
//

import SwiftUI

struct UserProfile: View {
    let firstName = UserDefaults.standard.string(forKey: "first_name_key") ?? ""
    let lastName = UserDefaults.standard.string(forKey: "last_name_key") ?? ""
    let email = UserDefaults.standard.string(forKey: "email_key") ?? ""
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Personal Information")
            Image("profile-image-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            Text("First Name: \(firstName)")
            Text("Last Name: \(lastName)")
            Text("Email: \(email)")
            
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: Constants.kIsLoggedIn)
                // When executed, it will automatically tell the NavigationView to go back to the previous screen which is Onboarding simulating logout.
                self.presentation.wrappedValue.dismiss()
            }
            
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
