//
//  NavigationBar.swift
//  Little Lemon
//
//  Created by dana chang on 7/10/24.
//

import SwiftUI

struct NavigationBar: View {
    @Binding var showProfile: Bool
    var showBackButton: Bool
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        HStack {
            if showBackButton {
                Button(action: {
                    showProfile = false
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .imageScale(.large)
                        .padding(10)
                        .background(Circle()
                            .fill(Color.primary1)
                            .shadow(radius: 3))
                }
            } else {
                Spacer()
            }
            
            Spacer()
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(height: 30)
            Spacer()
            Button(action: {
                showProfile = true
            }) {
                Image("profile-image-placeholder")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
        }
        .padding(.vertical, 10)
        .background(Color.white)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
   @State var showProfile = false
   return NavigationBar(showProfile: $showProfile, showBackButton: true)
}
