//
//  RocketInfoDataModel.swift
//  SpaceXClient
//
//  Created by Alin Gorgan on 6/3/21.
//

import Foundation

struct RocketInfoDataModel: Decodable {
    let id: String
    let name: String
    let rocketType: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case rocketType = "type"
    }
}
