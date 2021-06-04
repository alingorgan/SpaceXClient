//
//  MockDispatchQueue.swift
//  SpaceXClientTests
//
//  Created by Alin Gorgan on 6/4/21.
//

@testable import SpaceXClient

final class MockDispatchQueue: Dispatching {
    
    func async(do work: @escaping @convention(block) () -> Void) {
        work()
    }
    
    func sync(do work: @escaping @convention(block) () -> Void) {
        work()
    }
}
