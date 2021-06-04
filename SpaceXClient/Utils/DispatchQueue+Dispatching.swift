//
//  DispatchQueue+Dispatching.swift
//  SpaceXClient
//
//  Created by Alin Gorgan on 6/4/21.
//

import Foundation

protocol Dispatching {
    func async(do work: @escaping @convention(block) () -> Void)
    func sync(do work: @escaping @convention(block) () -> Void)
}

extension DispatchQueue: Dispatching {
    func async(do work: @escaping @convention(block) () -> Void) {
        async(execute: work)
    }
    
    func sync(do work: @escaping @convention(block) () -> Void) {
        sync(execute: work)
    }
}
