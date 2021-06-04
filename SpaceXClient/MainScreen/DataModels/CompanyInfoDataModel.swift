//
//  CompanyInfoDataModel.swift
//  SpaceXClient
//
//  Created by Alin Gorgan on 6/3/21.
//

import Foundation

struct CompanyInfoDataModel: Decodable {
    let name: String
    let founder: String
    let founded: Int
    let employees: Int
    let launchSites: Int
    let valuation: Double
    
    enum CodingKeys: String, CodingKey {
        case name
        case founder
        case founded
        case employees
        case launchSites = "launch_sites"
        case valuation
    }
}
