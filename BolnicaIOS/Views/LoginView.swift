//
//  LoginView.swift
//  BolnicaIOS
//
//  Created by Ivan Jovanovik on 14/03/2024.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var viewModel: LoginViewViewModel
    @State private var authenticationResult = ""
    var body: some View {
        VStack {
            LoginHeaderView()
            
            Form {
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundStyle(.red)
                }
                
                TextField("Username", text: $viewModel.username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.username)
                    .disableAutocorrection(true)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                BButton(title: "Log in",
                        background: .cyan) {
                    Task {
                        do {
                            let response = try await viewModel.login()
                            if response.status {
                                viewModel.authenticatedUser = response
                                
                                do {
                                    try KeychainManager.saveLoginToken(service: "hospital.api", account: "doctor.account", userObject: response)
                                } catch {
                                    print(error)
                                }
                                authenticationResult = "Authentication successful: \(response.message)"
                            } else {
                                authenticationResult = "Authentication failed: \(response.message)"
                            }
                        } catch {
                            authenticationResult = "Authentication failed: \(error.localizedDescription)"
                        }
                    }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    LoginView()
}
