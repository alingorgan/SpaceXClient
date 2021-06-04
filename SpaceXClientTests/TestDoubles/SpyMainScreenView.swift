//
//  MainScreenViewSpy.swift
//  SpaceXClientTests
//
//  Created by Alin Gorgan on 6/4/21.
//

@testable import SpaceXClient

final class SpyMainScreenView: MainScreenView {
    
    enum CallRecord {
        case didSetViewModel(MainScreenViewModel)
    }
    
    private(set) var callRecord = [CallRecord]()
    
    var viewModel = MainScreenViewModel.empty {
        didSet {
            callRecord.append(.didSetViewModel(viewModel))
        }
    }
}

extension SpyMainScreenView.CallRecord: Equatable {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.didSetViewModel, .didSetViewModel):
            return true
        }
    }
}

extension MainScreenViewModel: Equatable {
    public static func == (lhs: MainScreenViewModel, rhs: MainScreenViewModel) -> Bool {
        switch (lhs, rhs) {
        case (.empty, .empty):
            return true
        case (.loadingData, .loadingData):
            return true
        case (.error, .error):
            return true
        case (.loaded, .loaded):
            return true
        default:
            return false
        }
    }
}
