//
//  MainScreenViewModel.swift
//  SpaceXClient
//
//  Created by Alin Gorgan on 5/27/21.
//

import Foundation

enum LoadingPhase {
    case companyInfo
    case launches
}

enum MainScreenViewModel {
    case empty
    case loadingData
    case error(message: String)
    case loaded(companyInfo: CompanyInfo?,
                launches: [LaunchInfo],
                loadingPhase: LoadingPhase)
}

extension MainScreenViewModel {
    
    var companyInfo: CompanyInfo? {
        get { loadedItems.0 }
    }
    
    var launches: [LaunchInfo] {
        get { loadedItems.1 }
    }
    
    func displayableForItem(at indexPath: IndexPath) -> Any? {
        guard case let .loaded(
                companyInfo: companyInfo,
                launches: launches,
                loadingPhase: _) = self else {
            return nil
        }
        
        switch indexPath.section {
        case 0:
            return companyInfo
        case 1:
            return launches[indexPath.row]
        default:
            return nil
        }
    }
    
    func itemCountForSection(at index: Int) -> Int {
        switch (index, self) {
        case (0, .loaded):
            return 1
        case (1, .loaded(companyInfo: _, launches: let launches, loadingPhase: _)):
            return launches.count
        default:
            return 0
        }
    }
    
    private var loadedItems: (CompanyInfo?, [LaunchInfo]) {
        get {
            switch self {
            case .loaded(companyInfo: let companyInfo, launches: let launches, loadingPhase: _):
                return (companyInfo, launches)
            default:
                return (nil, [])
            }
        }
    }
}

