//
//  Gateway.swift
//
//  Created by Alin Gorgan on 5/12/21.
//

import Foundation

struct SpaceXUrlFactory: URLMaking {
    let configuration = Configuration()
    
    func make(method: EndpointMethod) -> URL {
        let urlString = configuration.baseURL
            + "/"
            + method.description
        
        guard let url = URL(string: urlString) else {
            preconditionFailure("Malformed URL format for \(urlString)")
        }
        
        return url
    }
}

extension SpaceXUrlFactory {
    struct Configuration {
        let baseURL = "https://api.spacexdata.com/v4"
    }
}
