//
//  LaunchInfoDataModel+Stub.swift
//  SpaceXClientTests
//
//  Created by Alin Gorgan on 6/4/21.
//

@testable import SpaceXClient

extension LaunchInfoDataModel {
    static func stub(
        name: String = "",
        imageURL: String? = nil,
        fireDateTime: String = "",
        isSuccessfullLaunch: Bool? = nil,
        rocketId: String = "") -> Self {
        
        self.init(
            name: name,
            imageURL: imageURL,
            fireDateTime: fireDateTime,
            isSuccessfullLaunch: isSuccessfullLaunch,
            rocketId: rocketId)
    }
}
