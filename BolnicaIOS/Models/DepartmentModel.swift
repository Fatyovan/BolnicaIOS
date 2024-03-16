//
//  DepartmentModel.swift
//  BolnicaIOS
//
//  Created by Ivan Jovanovik on 16/03/2024.
//

import Foundation

struct Department: Codable {
    let id: String
    let name: String
}

struct DepartmentsResponse: Codable {
    let success: Bool
    let data: [Department]
}
