//
//  EndpointMethod.swift
//
//  Created by Alin Gorgan on 5/12/21.
//

import Foundation

protocol EndpointMethod: CustomStringConvertible { }

enum SpaceXEndpointMethod: EndpointMethod {
    case companyInfo
    case allLaunches
    case rocket(id: String)
    
    var description: String {
        switch self {
        case .companyInfo:
            return "company"
        case .allLaunches:
            return "launches"
        case .rocket(id: let id):
            return "rockets/\(id)"
        }
    }
}
