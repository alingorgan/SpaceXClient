//
//  CompanyInfo.swift
//  SpaceXClient
//
//  Created by Alin Gorgan on 6/3/21.
//

import Foundation

struct CompanyInfo: Equatable {
    let name: String
    let founder: String
    let year: Int
    let employeeCount: Int
    let launchSiteCount: Int
    let valuation: String
}

extension CompanyInfo {
    init(dataModel: CompanyInfoDataModel) {
        self.init(
            name: dataModel.name,
            founder: dataModel.founder,
            year: dataModel.founded,
            employeeCount: dataModel.employees,
            launchSiteCount: dataModel.launchSites,
            valuation: dataModel.valuation.abbreviated)
    }
}
