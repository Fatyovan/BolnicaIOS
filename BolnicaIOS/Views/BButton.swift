//
//  BButton.swift
//  BolnicaIOS
//
//  Created by Ivan Jovanovik on 14/03/2024.
//

import SwiftUI

struct BButton: View {
    let title: String
    let background: Color
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(background)
                Text(title)
                    .foregroundStyle(.white)
                    .bold()
            }
        }
        .padding()
    }
}

#Preview {
    BButton(title: "Value",
            background: .pink) {
        //Action
    }
}
