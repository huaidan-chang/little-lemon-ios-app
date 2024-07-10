//
//  Onboarding.swift
//  Little Lemon
//
//  Created by dana chang on 7/9/24.
//

import SwiftUI

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                Text("First name *")
                TextField("First Name", text: $firstName)
                Text("Last name *")
                TextField("Last Name", text: $lastName)
                Text("E-mail *")
                TextField("E-mail", text: $email)
                Button("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: Constants.kFirstName)
                        UserDefaults.standard.set(lastName, forKey: Constants.kLastName)
                        UserDefaults.standard.set(email, forKey: Constants.kEmail)
                        UserDefaults.standard.set(true, forKey: Constants.kIsLoggedIn)
                        isLoggedIn = true
                    }
                }
            }
            
        }
        .onAppear() {
            if UserDefaults.standard.bool(forKey: Constants.kIsLoggedIn) {
                isLoggedIn = true
            }
        }
    }
}

#Preview {
    Onboarding()
}
