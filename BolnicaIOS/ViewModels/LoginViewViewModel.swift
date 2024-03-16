//
//  LoginViewViewModel.swift
//  BolnicaIOS
//
//  Created by Ivan Jovanovik on 14/03/2024.
//

import Foundation

class LoginViewViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var authenticatedUser: AuthenticatedUser? = nil
    @Published var authToken: String = ""
    
    init() {
        //imitating logout
//        do {
//            try KeychainManager.deleteAllData()
//            print("Keychain data deleted successfully")
//        } catch {
//            print("Error deleting keychain data: \(error)")
//        }

        do {
           if let authenticatedUser = try KeychainManager.getLoginData(
                service: "hospital.api",
                account: "doctor.account") {
               self.authenticatedUser = authenticatedUser
           } else {
               debugPrint("error object not found in keychain")
           }
            
            
        } catch {
            print("Error retriving user object")
        }
    }
    
    func login() async throws -> AuthenticatedUser {
        DispatchQueue.main.async {
            self.errorMessage = ""
        }
        guard !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            DispatchQueue.main.async {
                self.errorMessage = "Please fill in all fields"
            }
            
            throw AuthenticationError.invalidCredentials
        }
        
        let endpoint = "https://hospital.karovski.mk/api/api/V1/users/login"
        
        guard let url = URL(string: endpoint) else {
            throw AuthenticationError.invalidURL
        }
        let credentials = Credentials(u: username, p: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(credentials)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let response = try? decoder.decode(AuthenticatedUser.self, from: data) else {
            throw AuthenticationError.invalidResponse
        }
        
        return response
        
    }
    
    func validate(){
        
    }
}

struct User: Codable {
    
}

struct Credentials: Codable {
    let u: String
    let p: String
}

struct AuthenticatedUser: Codable {
    let status: Bool
    let message: String
    let publicId: String
    var token: String
}

enum AuthenticationError: Error {
    case invalidURL
    case invalidResponse
    case invalidCredentials
}
