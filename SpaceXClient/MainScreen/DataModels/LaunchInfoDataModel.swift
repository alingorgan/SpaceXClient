//
//  LaunchInfoDataModel.swift
//  SpaceXClient
//
//  Created by Alin Gorgan on 6/3/21.
//

import Foundation

struct LaunchInfoDataModel: Decodable {
    let name: String
    let imageURL: String?
    let fireDateTime: String
    let isSuccessfullLaunch: Bool?
    let rocketId: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageURL
        case fireDateTime = "date_local"
        case isSuccessfullLaunch = "success"
        case rocketId = "rocket"
        case links
    }
    
    enum LinksCodingKeys: String, CodingKey {
        case patch
    }
    
    enum PatchCodingKeys: String, CodingKey {
        case small
    }
    
    init(name: String,
        imageURL: String?,
        fireDateTime: String,
        isSuccessfullLaunch: Bool?,
        rocketId: String) {
        
        self.name = name
        self.imageURL = imageURL
        self.fireDateTime = fireDateTime
        self.isSuccessfullLaunch = isSuccessfullLaunch
        self.rocketId = rocketId
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.fireDateTime = try container.decode(String.self, forKey: .fireDateTime)
        self.isSuccessfullLaunch = try container.decodeIfPresent(Bool.self, forKey: .isSuccessfullLaunch)
        self.rocketId = try container.decode(String.self, forKey: .rocketId)
        
        let linksContainer = try container.nestedContainer(keyedBy: LinksCodingKeys.self, forKey: .links)
        let patchContainer = try linksContainer.nestedContainer(keyedBy: PatchCodingKeys.self, forKey: .patch)
        self.imageURL = try patchContainer.decodeIfPresent(String.self, forKey: .small)
    }
}
