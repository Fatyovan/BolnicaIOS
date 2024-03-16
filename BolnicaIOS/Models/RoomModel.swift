//
//  RoomModel.swift
//  BolnicaIOS
//
//  Created by Ivan Jovanovik on 16/03/2024.
//

import Foundation

struct Room: Codable {
    let id: String
    let number: String
    let publicId: String
    let floorId: String
    let departmentId: String
    let companyId: String
    let floorName: String
    let departmentName: String
    let totalBeds: String
    let roomsGroup: String


}

struct RoomsResponse: Codable {
    let success: Bool
    let data: [Room]
}
