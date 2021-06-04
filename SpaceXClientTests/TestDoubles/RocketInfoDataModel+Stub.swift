//
//  RocketInfoDataModel+Stub.swift
//  SpaceXClientTests
//
//  Created by Alin Gorgan on 6/4/21.
//

@testable import SpaceXClient

extension RocketInfoDataModel {
    static func stub(
        id: String = "",
        name: String = "",
        rocketType: String = "") -> Self {
        
        self.init(
            id: id,
            name: name,
            rocketType: rocketType)
    }
}
