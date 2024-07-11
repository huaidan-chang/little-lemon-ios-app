//
//  Little_LemonApp.swift
//  Little Lemon
//
//  Created by dana chang on 7/9/24.
//

import SwiftUI

@main
struct LittleLemonApp: App {
    @State var loaded = false
    var body: some Scene {
        WindowGroup {
            Onboarding(loaded: $loaded)
        }
    }
}
