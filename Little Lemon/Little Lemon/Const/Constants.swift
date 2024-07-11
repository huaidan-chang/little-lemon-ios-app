//
//  Constants.swift
//  Little Lemon
//
//  Created by dana chang on 7/9/24.
//

import Foundation

struct Constants {
    static let kFirstName = "first_name_key"
    static let kLastName = "last_name_key"
    static let kEmail = "email_key"
    static let kIsLoggedIn = "kIsLoggedIn"
    static let kReceiveOrderUpdates = "order_updates_key"
    static let kReceivePasswordChangeNotification = "password_change_notification_key"
    static let kReceiveSpecialOffers = "special_offers_key"
    static let kSubscribeToNewsletter = "subscribe_newsletter_key"
}

enum Category: String, CaseIterable {
    case all = "all"
    case starters = "starters"
    case mains = "mains"
    case desserts = "desserts"
    case drinks = "drinks"
}
