//
//  Home.swift
//  Little Lemon
//
//  Created by dana chang on 7/9/24.
//

import SwiftUI

struct Home: View {
    let persistence = PersistenceController.shared
    @State var showProfile = false
    @State var searchText = ""
    @State var selectedCategory: Category = .all
    @Binding var loaded: Bool
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: UserProfile(showProfile: $showProfile, loaded: $loaded), isActive: $showProfile) {
                    EmptyView()
                }
                Spacer(minLength: 15)
                VStack {
                    Hero()
                    TextField("Search menu", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                .background(Color.primary1)
                
                Text("ORDER FOR DELIVERY!")
                    .font(.KarlaSectionTitle())
                    .foregroundColor(.secondary4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Category.allCases, id: \.self) { category in
                            Button(action: {
                                self.selectedCategory = category
                            }) {
                                Text(category.rawValue)
                                    .padding(12)
                                    .background(self.selectedCategory == category ? Color.primary1 : Color.gray.opacity(0.2))
                                    .foregroundColor(self.selectedCategory == category ? .white : .primary1)
                                    .font(.KarlaSectionCategories())
                                    .cornerRadius(16)
                            }
                        }
                    }
                    .padding(6)
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    Menu(loaded: $loaded, searchText: $searchText, selectedCategory: $selectedCategory).environment(\.managedObjectContext, persistence.container.viewContext)
                }.padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    NavigationBar(showProfile: $showProfile, showBackButton: false).background(Color.white)
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    Home()
//}
