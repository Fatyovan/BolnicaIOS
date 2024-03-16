//
//  LoginHeaderView.swift
//  BolnicaIOS
//
//  Created by Ivan Jovanovik on 14/03/2024.
//

import SwiftUI

struct LoginHeaderView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundStyle(.cyan)
                .rotationEffect(Angle(degrees: 15))
            
            VStack {
                Text("Hospital")
                    .font(.system(size: 50))
                    .foregroundStyle(.white)
                    .bold()
                Text("Gynecology")
                    .font(.system(size: 30))
                    .foregroundStyle(.white)
            }
            .padding(.top, 30)
        }
        .frame(width: UIScreen.main.bounds.width * 3,
               height: 300)
        .offset(y: -100)
    }
}

#Preview {
    LoginHeaderView()
}
