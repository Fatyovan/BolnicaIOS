//
//  HomeView.swift
//  BolnicaIOS
//
//  Created by Ivan Jovanovik on 15/03/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var loginViewModel: LoginViewViewModel
    @StateObject var homeViewViewModel = HomeViewViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            BButton(title: "Get all rooms", background: .green) {
                Task {
                    do {
                        let rooms = try await homeViewViewModel.getRooms(token: loginViewModel.authToken)
                        debugPrint("data\(rooms)")
//                        let departments = try await homeViewViewModel.getDepartments(token: loginViewModel.authToken)
                        
//                        debugPrint("Departments: \(departments)")
                    } catch {
                        print(error)
                    }
                }
            }
            .frame(width: 100, height: 60)
            Spacer()
        }
    }
}

#Preview {
    HomeView()
}
