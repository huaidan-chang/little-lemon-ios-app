//
//  Validator.swift
//  Little Lemon
//
//  Created by dana chang on 7/11/24.
//

import Foundation

import Foundation

struct Validator {
    static func validateUserInput(firstName: String, lastName: String, email: String) -> (isValid: Bool, errorMessage: String)  {
        if firstName.isEmpty || lastName.isEmpty || email.isEmpty {
            return (false, "Please complete all required fields.")
        }
        
        if !email.isValidEmail() {
            return (false, "Please enter a valid email address.")
        }
        
        return (true, "")
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
}
