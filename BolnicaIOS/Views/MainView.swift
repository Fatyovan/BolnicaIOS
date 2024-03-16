//
//  ContentView.swift
//  BolnicaIOS
//
//  Created by Ivan Jovanovik on 14/03/2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: LoginViewViewModel = LoginViewViewModel()
    @State var selectedTab = 0
    
    var body: some View {
        NavigationView {
            if let user = viewModel.authenticatedUser, !user.token.isEmpty {
                
                
                ZStack(alignment: .bottom){
                    TabView {
                        HomeView()
                            .tag(0)
                        InfoView()
                            .tag(1)
                        ProfileView()
                            .tag(2)
                    }
                    ZStack{
                        HStack{
                            ForEach((TabbedItems.allCases), id: \.self){ item in
                                Button{
                                    selectedTab = item.rawValue
                                } label: {
                                    CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                                }
                            }
                        }
                        .padding(6)
                    }
                    .frame(height: 70)
                    .background(.cyan.opacity(0.2))
                    .cornerRadius(35)
                    .padding(.horizontal, 26)

                }
            } else {
                LoginView()
            }
        }
        .environmentObject(viewModel)
        
    }
}

extension MainView {
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
            HStack(spacing: 10){
                Spacer()
                Image(systemName: imageName)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(isActive ? .black : .gray)
                    .frame(width: 20, height: 20)
                if isActive{
                    Text(title)
                        .font(.system(size: 14))
                        .foregroundColor(isActive ? .black : .gray)
                }
                Spacer()
            }
            .frame(width: isActive ? .infinity : 60, height: 60)
            .background(isActive ? .cyan.opacity(0.5) : .clear)
            .cornerRadius(30)
        }
}

#Preview {
    MainView()
}
enum TabbedItems: Int, CaseIterable{
    case home = 0
    case profile
    case info
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .info:
            return "Informations"
        case .profile:
            return "Profile"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "house"
        case .info:
            return "info.bubble"
        case .profile:
            return "person.circle"
        }
    }
}
