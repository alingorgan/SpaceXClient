//
//  MainScreenInteractorSpy.swift
//  SpaceXClientTests
//
//  Created by Alin Gorgan on 6/4/21.
//

@testable import SpaceXClient

final class MockMainScreenInteractor: MainScreenInteracting {
    
    enum CallRecord {
        case loadCompanyInfo
        case loadLaunches
        case loadRocketInfo
    }
    
    private(set) var callRecord = [CallRecord]()
    
    var stubCompanyInfoResult: Result<CompanyInfoDataModel, FetchError>?
    var stubLaunchInfoResult: Result<[LaunchInfoDataModel], FetchError>?
    var stubRocketInfoResult: Result<RocketInfoDataModel, FetchError>?
    
    func loadCompanyInfo(completion: @escaping (Result<CompanyInfoDataModel, FetchError>) -> Void) {
        callRecord.append(.loadCompanyInfo)
        guard let result = stubCompanyInfoResult else { return }
        completion(result)
    }
    
    func loadLaunches(completion: @escaping (Result<[LaunchInfoDataModel], FetchError>) -> Void) {
        callRecord.append(.loadLaunches)
        guard let result = stubLaunchInfoResult else { return }
        completion(result)
    }
    
    func loadRocketInfo(with id: String, completion: @escaping (Result<RocketInfoDataModel, FetchError>) -> Void) {
        callRecord.append(.loadRocketInfo)
        guard let result = stubRocketInfoResult else { return }
        completion(result)
    }
}
