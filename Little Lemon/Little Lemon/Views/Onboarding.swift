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
    @State private var errorMessageShow = false
    @State private var errorMessage = ""
    @Binding var loaded: Bool
    var body: some View {
        NavigationStack {
            HStack {
                Image("Logo") // Ensure this image is available in your assets
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
            }
            .padding(.vertical, 10)
            .background(Color.white)
            .frame(maxWidth: .infinity)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Hero()
                }
                .padding()
                .background(Color.primary1)
                VStack {
                    NavigationLink(destination: Home(loaded: $loaded), isActive: $isLoggedIn) {
                        EmptyView()
                    }
                    VStack {
                        Text("First name *")
                            .font(.KarlaHighlightText())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TextField("First Name", text: $firstName)
                        Text("Last name *")
                            .font(.KarlaHighlightText())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TextField("Last Name", text: $lastName)
                        Text("E-mail *")
                            .font(.KarlaHighlightText())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TextField("E-mail", text: $email)
                    }
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                    .padding()
                    
                    if errorMessageShow {
                        withAnimation() {
                            Text(errorMessage)
                                .font(.KarlaHighlightText())
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                        }
                    }
                    
                    Spacer(minLength: 30)
                    
                    Button("Register") {
                        self.register()
                    }.buttonStyle(LogOutButtonStyle())
                }
            } 
            .onAppear() {
                if UserDefaults.standard.bool(forKey: Constants.kIsLoggedIn) {
                    isLoggedIn = true
                }
            
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func register() {
        let validation = Validator.validateUserInput(firstName: firstName, lastName: lastName, email: email)
        if validation.isValid {
            UserDefaults.standard.set(firstName, forKey: Constants.kFirstName)
            UserDefaults.standard.set(lastName, forKey: Constants.kLastName)
            UserDefaults.standard.set(email, forKey: Constants.kEmail)
            UserDefaults.standard.set(true, forKey: Constants.kIsLoggedIn)
            
            UserDefaults.standard.set(false, forKey: Constants.kReceiveOrderUpdates)
            UserDefaults.standard.set(false, forKey: Constants.kReceiveSpecialOffers)
            UserDefaults.standard.set(false, forKey: Constants.kSubscribeToNewsletter)
            UserDefaults.standard.set(false, forKey: Constants.kReceivePasswordChangeNotification)
            isLoggedIn = true
        } else {
            errorMessage = validation.errorMessage
            errorMessageShow = true
        }
    }
}

//#Preview {
//    Onboarding()
//}
