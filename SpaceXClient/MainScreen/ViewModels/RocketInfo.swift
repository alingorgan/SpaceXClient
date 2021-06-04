//
//  RocketInfo.swift
//  SpaceXClient
//
//  Created by Alin Gorgan on 6/3/21.
//

import Foundation

struct RocketInfo: Equatable {
    let id: String
    let name: String?
    let type: String?
}

extension RocketInfo {
    init(dataModel: RocketInfoDataModel) {
        self.init(id: dataModel.id, name: dataModel.name, type: dataModel.rocketType)
    }
}
