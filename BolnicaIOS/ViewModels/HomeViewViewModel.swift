//
//  HomeViewViewModel.swift
//  BolnicaIOS
//
//  Created by Ivan Jovanovik on 15/03/2024.
//

import Foundation


class HomeViewViewModel: ObservableObject {
    
    
    init() {}
    
    
    func getRooms(token: String) async throws -> RoomsResponse {
        let endpoint = "https://hospital.karovski.mk/api/api/V1/rooms/get-all"
        
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        print(String(data: data, encoding: .utf8) ?? "Empty response")
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(RoomsResponse.self, from: data)
        } catch {
            throw APIError.invalidData
        }
    }
    
    func getDepartments(token: String) async throws -> DepartmentsResponse {
        let endpoint = "https://hospital.karovski.mk/api/api/V1/departments/get-all"
        
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        print(String(data: data, encoding: .utf8) ?? "Empty response")
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(DepartmentsResponse.self, from: data)
        } catch {
            throw APIError.invalidData
        }
        
//        return String(data: data, encoding: .utf8) ?? ""
    }
}


enum APIError: Error {
    case invalidURL
    case invalidResponse
    case networkError(Error)
    case httpError(Int)
    case unexpectedError
    case invalidData
}
