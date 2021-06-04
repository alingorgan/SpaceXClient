//
//  MainScreenInteracting.swift
//  SpaceXClient
//
//  Created by Alin Gorgan on 6/3/21.
//

import Foundation

protocol MainScreenInteracting {
    func loadCompanyInfo(completion: @escaping (Result<CompanyInfoDataModel, FetchError>) -> Void)
    
    func loadLaunches(completion: @escaping (Result<[LaunchInfoDataModel], FetchError>) -> Void)
    
    func loadRocketInfo(with id: String,
                        completion: @escaping (Result<RocketInfoDataModel, FetchError>) -> Void)
}
