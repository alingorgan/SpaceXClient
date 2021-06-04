//
//  CompanyInfoDataModel+Stub.swift
//  SpaceXClientTests
//
//  Created by Alin Gorgan on 6/4/21.
//

@testable import SpaceXClient

extension CompanyInfoDataModel {
    static func stub(
        name: String = "",
        founder: String = "",
        founded: Int = 0,
        employees: Int = 0,
        launchSites: Int = 0,
        valuation: Double = 0) -> Self {
        
        self.init(
            name: name,
            founder: founder,
            founded: founded,
            employees: employees,
            launchSites: launchSites,
            valuation: valuation)
    }
}
