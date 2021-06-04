//
//  LaunchInfo.swift
//  SpaceXClient
//
//  Created by Alin Gorgan on 6/3/21.
//

import Foundation

struct LaunchInfo: Equatable {
    let mission: MissonInfo
    let rocketInfo: RocketInfo?
}

extension Array where Element == LaunchInfo {
    init(dataModels: [LaunchInfoDataModel]) {
        self = dataModels.map { .init(dataModel: $0) }
    }
}

extension LaunchInfo {
    init(dataModel: LaunchInfoDataModel, rocketInfoDataModel: RocketInfoDataModel? = nil) {
        
        var dateFormatted = ""
        var timeFormatted = ""
        var etdFormatted = ""
        
        let dateInputFormatter = DateFormatter()
        dateInputFormatter.locale = .current
        dateInputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        if let inputDate = dateInputFormatter.date(from: dataModel.fireDateTime) {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .current
            dateFormatter.dateFormat = "YYYY-MM-dd"
            dateFormatted = dateFormatter.string(from: inputDate)
            
            let timeForFormatter = DateFormatter()
            dateFormatter.locale = .current
            dateFormatter.dateFormat = "HH:mm:ss"
            timeFormatted = timeForFormatter.string(from: inputDate)
            
            let diffComponents = Calendar.current.dateComponents([.day], from: .init(), to: inputDate)
            if let days = diffComponents.day {
                etdFormatted = "\(days)"
            }
        }
        
        let rocketInfo: RocketInfo
        if let rocketInfoDataModel = rocketInfoDataModel {
            rocketInfo = RocketInfo(dataModel: rocketInfoDataModel)
        } else {
            rocketInfo = RocketInfo(id: dataModel.rocketId, name: nil, type: nil)
        }
        
        self.init(mission: .init(name: dataModel.name,
                                 imageUrl: dataModel.imageURL,
                                 dateFormatted: dateFormatted,
                                 timeFormatted: timeFormatted,
                                 etdFormatted: etdFormatted,
                                 isSuccessfullLaunch: dataModel.isSuccessfullLaunch),
                  rocketInfo: rocketInfo)
    }
}
