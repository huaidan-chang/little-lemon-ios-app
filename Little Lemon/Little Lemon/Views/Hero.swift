//
//  Hero.swift
//  Little Lemon
//
//  Created by dana chang on 7/11/24.
//

import SwiftUI

struct Hero: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Little Lemon")
                .foregroundColor(Color.primary2)
                .font(.MarkaziTitle())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, -20)
            
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Chicago")
                        .foregroundColor(.white)
                        .font(.MarkaziSubTitle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .lineLimit(nil) // Remove line limit to show complete text
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.white)
                        .font(.KarlaLeadText())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack {
                    Spacer()
                    Image("Hero image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 120, maxHeight: 140)
                        .clipShape(Rectangle())
                        .cornerRadius(16)
                }
            }
        }
        .padding(.top, -10)
    }
}

#Preview {
    Hero()
}
