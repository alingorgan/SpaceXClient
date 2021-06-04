//
//  MainScreenPresenter.swift
//  SpaceXClient
//
//  Created by Alin Gorgan on 5/27/21.
//

import Foundation

final class MainScreenPresenter: MainScreenPresenting {
    
    private let interactor: MainScreenInteracting
    private let mainQueue: Dispatching
    private let globalQueue: Dispatching
    
    unowned var view: MainScreenView
    
    init(view: MainScreenView,
         interactor: MainScreenInteracting,
         mainQueue: Dispatching,
         globalQueue: Dispatching) {
        
        self.view = view
        self.interactor = interactor
        self.mainQueue = mainQueue
        self.globalQueue = globalQueue
    }
    
    func viewDidLoad() {
        viewDidRefresh()
    }
    
    func viewDidRefresh() {
        view.viewModel = .loadingData
        interactor.loadCompanyInfo(completion: handle)
        interactor.loadLaunches(completion: handle)
    }
    
    private func handle(companyInfoResult: Result<CompanyInfoDataModel, FetchError>) {
        let viewModel: MainScreenViewModel
        switch companyInfoResult {
        case .success(let companyInfoDataModel):
            viewModel = .loaded(
                companyInfo: .init(dataModel: companyInfoDataModel),
                launches: [],
                loadingPhase: .companyInfo)
        case .failure(let error):
            viewModel = .error(message: error.description)
        }
        
        mainQueue.async { [weak view] in
            view?.viewModel = viewModel
        }
    }
    
    private func handle(launchInfoResult: Result<[LaunchInfoDataModel], FetchError>) {
        switch launchInfoResult {
        case .success(let launchInfos):
            process(launchInfos)
        case .failure(let error):
            process(error)
        }
    }
    
    private func process(_ launchInfos: [LaunchInfoDataModel]) {
        let rocketInfoMap = NSMutableDictionary()
        var loadedInfos = 0
        launchInfos.forEach { launchInfo in
            globalQueue.sync {
                self.interactor.loadRocketInfo(with: launchInfo.rocketId) { result in
                    guard case .success(let rocketInfoDataModel) = result else {
                        return
                    }
                    rocketInfoMap[launchInfo.rocketId] = rocketInfoDataModel
                    loadedInfos += 1
                    
                    guard loadedInfos == launchInfos.count else { return }
                    
                    let launches = [LaunchInfo](dataModels: launchInfos)
                    let updatedLaunches: [LaunchInfo] = launches.map {
                        guard let rocketId = $0.rocketInfo?.id else { return $0 }
                        var rocketInfo = $0.rocketInfo
                        if let rocketInfoDataModel = rocketInfoMap[rocketId] as? RocketInfoDataModel {
                            rocketInfo = RocketInfo(dataModel: rocketInfoDataModel)
                        }
                        return LaunchInfo(mission: $0.mission, rocketInfo: rocketInfo)
                    }
                    
                    self.mainQueue.async { [weak self] in
                        self?.view.viewModel = .loaded(
                            companyInfo: self?.view.viewModel.companyInfo,
                            launches: updatedLaunches,
                            loadingPhase: .launches)
                    }
                }
            }
        }
    }
    
    private func process(_ error: FetchError) {
        let viewModel = MainScreenViewModel.error(message: error.description)
        DispatchQueue.main.async { [weak view] in
            view?.viewModel = viewModel
        }
    }
}

extension FetchError {
    var description: String {
        get {
            switch self {
            case .cannotDecodeData:
                return "Cannot decode data"
            case .cannotFetchData:
                return "Cannot fetch data"
            }
        }
    }
}
