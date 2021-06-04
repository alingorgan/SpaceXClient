//
//  MissionInfo.swift
//  SpaceXClient
//
//  Created by Alin Gorgan on 6/3/21.
//

import Foundation

struct MissonInfo: Equatable {
    let name: String
    let imageUrl: String?
    let dateFormatted: String
    let timeFormatted: String
    let etdFormatted: String
    let isSuccessfullLaunch: Bool?
}
