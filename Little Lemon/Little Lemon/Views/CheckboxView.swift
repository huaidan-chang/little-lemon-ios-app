//
//  CheckboxView.swift
//  Little Lemon
//
//  Created by dana chang on 7/11/24.
//

import SwiftUI

struct CheckboxView: View {
    @Binding var isChecked: Bool
    let label: String

    var body: some View {
        Button(action: {
            self.isChecked.toggle() // Toggle the state of the checkbox
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square") // Change the icon based on state
                    .foregroundColor(isChecked ? .primary1 : .gray) // Change color when checked
                    .font(.system(size: 20)) // Size of the checkbox
                Text(label)
                    .font(.KarlaParagraphText())
                    .foregroundColor(.primary)
            }
        }
    }
}

