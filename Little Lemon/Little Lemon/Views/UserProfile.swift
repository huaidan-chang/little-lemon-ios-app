//
//  UserProfile.swift
//  Little Lemon
//
//  Created by dana chang on 7/9/24.
//

import SwiftUI

struct UserProfile: View {
    @Binding var showProfile: Bool
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber: String = ""
    
    @State private var receiveOrderUpdates: Bool = false
    @State private var receivePasswordChangeNotification: Bool = false
    @State private var receiveSpecialOffers: Bool = false
    @State private var subscribeToNewsletter: Bool = false
    
    @State private var errorMessageShow = false
    @State private var errorMessage = ""
    @State private var isEditing = false
    
    @Environment(\.presentationMode) var presentation
    @State private var isLoggedOut = false
    @Binding var loaded: Bool
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            NavigationLink(destination: Onboarding(loaded: $loaded), isActive: $isLoggedOut) {
                EmptyView()
            }
            VStack (spacing: 3) {
                VStack(alignment: .leading) {
                    Text("Personal information").font(.KarlaSectionTitle())
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Image("profile-image-placeholder")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 90, height: 90)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    HStack(spacing: 0) {
                        Button("Change") {
                            isEditing = true
                        }
                        .buttonStyle(ButtonStylePrimary())
                        Button("Remove") {
                            firstName = ""
                            lastName = ""
                            email = ""
                        }
                        .buttonStyle(ButtonStyleWhite())
                    }
                }
                .padding(.bottom, 5)
                .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    Group {
                        Text("First name").font(.KarlaParagraphText())
                        TextField("First name", text: $firstName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(!isEditing)
                        Text("Last name").font(.KarlaParagraphText())
                        TextField("Last name", text: $lastName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(!isEditing)
                        Text("Email").font(.KarlaParagraphText())
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(!isEditing)
                        Text("Phone number").font(.KarlaParagraphText())
                        TextField("Phone number", text: $phoneNumber)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(!isEditing)
                    }
                }.padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 3) {
                    Text("Email notifications").font(.KarlaSectionTitle())
                    CheckboxView(isChecked: $receiveOrderUpdates, label: "Order statuses")
                    CheckboxView(isChecked: $receivePasswordChangeNotification, label: "Password changes")
                    CheckboxView(isChecked: $receiveSpecialOffers, label: "Special offers")
                    CheckboxView(isChecked: $subscribeToNewsletter, label: "Newsletter")
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
                if errorMessageShow {
                    withAnimation() {
                        Text(errorMessage)
                            .font(.KarlaHighlightText())
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                    }
                }
                
                Button("Log out") {
                    UserDefaults.standard.set(false, forKey: Constants.kIsLoggedIn)
                    UserDefaults.standard.set("", forKey: Constants.kFirstName)
                    UserDefaults.standard.set("", forKey: Constants.kLastName)
                    UserDefaults.standard.set("", forKey: Constants.kEmail)
                    UserDefaults.standard.set(false, forKey: Constants.kSubscribeToNewsletter)
                    UserDefaults.standard.set(false, forKey: Constants.kReceiveOrderUpdates)
                    UserDefaults.standard.set(false, forKey: Constants.kReceiveSpecialOffers)
                    UserDefaults.standard.set(false, forKey: Constants.kReceivePasswordChangeNotification)
                    isLoggedOut = true
                }
                .buttonStyle(LogOutButtonStyle())
                
                Spacer(minLength: 15)
                HStack {
                    Button("Discard changes") {
                        firstName = UserDefaults.standard.string(forKey: Constants.kFirstName) ?? ""
                        lastName = UserDefaults.standard.string(forKey: Constants.kLastName) ?? ""
                        email = UserDefaults.standard.string(forKey: Constants.kEmail) ?? ""
                        receiveOrderUpdates = UserDefaults.standard.bool(forKey: Constants.kReceiveOrderUpdates)
                        receivePasswordChangeNotification = UserDefaults.standard.bool(forKey: Constants.kReceivePasswordChangeNotification)
                        receiveSpecialOffers = UserDefaults.standard.bool(forKey: Constants.kReceiveSpecialOffers)
                        subscribeToNewsletter = UserDefaults.standard.bool(forKey: Constants.kSubscribeToNewsletter)
                        isEditing = false
                    }
                    .buttonStyle(ButtonStyleWhite())
                    Button("Save changes") {
                        let validation = Validator.validateUserInput(firstName: firstName, lastName: lastName, email: email)
                        if validation.isValid {
                            UserDefaults.standard.set(firstName, forKey: Constants.kFirstName)
                            UserDefaults.standard.set(lastName, forKey: Constants.kLastName)
                            UserDefaults.standard.set(email, forKey: Constants.kEmail)
                            UserDefaults.standard.set(true, forKey: Constants.kIsLoggedIn)
                            UserDefaults.standard.set(subscribeToNewsletter, forKey: Constants.kSubscribeToNewsletter)
                            UserDefaults.standard.set(receiveSpecialOffers, forKey: Constants.kReceiveSpecialOffers)
                            UserDefaults.standard.set(receivePasswordChangeNotification, forKey: Constants.kReceivePasswordChangeNotification)
                            UserDefaults.standard.set(receiveOrderUpdates, forKey: Constants.kReceiveOrderUpdates)
                            isEditing = false
                        } else {
                            errorMessage = validation.errorMessage
                            errorMessageShow = true
                        }
                    }
                    .buttonStyle(ButtonStylePrimary())
                }.padding(.horizontal, 10)
                
            }
        }
        .onAppear {
            firstName = UserDefaults.standard.string(forKey: Constants.kFirstName) ?? ""
            lastName = UserDefaults.standard.string(forKey: Constants.kLastName) ?? ""
            email = UserDefaults.standard.string(forKey: Constants.kEmail) ?? ""
            receiveOrderUpdates = UserDefaults.standard.bool(forKey: Constants.kReceiveOrderUpdates)
            receivePasswordChangeNotification = UserDefaults.standard.bool(forKey: Constants.kReceivePasswordChangeNotification)
            receiveSpecialOffers = UserDefaults.standard.bool(forKey: Constants.kReceiveSpecialOffers)
            subscribeToNewsletter = UserDefaults.standard.bool(forKey: Constants.kSubscribeToNewsletter)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                NavigationBar(showProfile: $showProfile, showBackButton: true)
            }
        }
    }
}

//#Preview {
//    @State var showProfile = true
//    return  UserProfile(showProfile: $showProfile)
//}
