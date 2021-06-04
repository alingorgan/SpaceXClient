//
//  MainScreenPresenting.swift
//  SpaceXClient
//
//  Created by Alin Gorgan on 6/3/21.
//

import Foundation

protocol MainScreenPresenting {
    var view: MainScreenView { get }
    func viewDidLoad()
    func viewDidRefresh()
}
