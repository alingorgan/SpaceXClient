//
//  Router.swift
//  SpaceXClient
//
//  Created by Alin Gorgan on 5/27/21.
//

import UIKit

protocol Routing {
    func showMainScreen()
}

final class Router: Routing {
    
    private let storyboard: UIStoryboard
    
    let navigationController: UINavigationController
    
    init(storyboard: UIStoryboard, navigationController: UINavigationController) {
        self.storyboard = storyboard
        self.navigationController = navigationController
    }
    
    func showMainScreen() {
        guard let mainScreen = storyboard.instantiateInitialViewController() as? MainScreenViewController else {
            assertionFailure("Main screen not found")
            return
        }
        
        let interactor = MainScreenInteractor(dataFetcher: .init())
        
        mainScreen.presenter = MainScreenPresenter(
            view: mainScreen,
            interactor: interactor,
            mainQueue: DispatchQueue.main,
            globalQueue: DispatchQueue.global())
        
        navigationController.setViewControllers([mainScreen], animated: false)
    }
}
