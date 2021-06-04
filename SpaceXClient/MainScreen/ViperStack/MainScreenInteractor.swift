//
//  MainScreenInteractor.swift
//  SpaceXClient
//
//  Created by Alin Gorgan on 6/2/21.
//

import Foundation

final class MainScreenInteractor: MainScreenInteracting {
    
    private let dataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher) {
        self.dataFetcher = dataFetcher
    }
    
    func loadCompanyInfo(completion: @escaping (Result<CompanyInfoDataModel, FetchError>) -> Void) {
        dataFetcher.fetch(
            endpointMethod: SpaceXEndpointMethod.companyInfo,
            completion: completion)
    }
    
    func loadLaunches(completion: @escaping (Result<[LaunchInfoDataModel], FetchError>) -> Void) {
        dataFetcher.fetch(endpointMethod: SpaceXEndpointMethod.allLaunches,
                          completion: completion)
    }
    
    func loadRocketInfo(with id: String,
                        completion: @escaping (Result<RocketInfoDataModel, FetchError>) -> Void) {
        dataFetcher.fetch(
            endpointMethod: SpaceXEndpointMethod.rocket(id: id),
            completion: completion)
    }
}
