//
//  URLFactory.swift
//
//  Created by Alin Gorgan on 5/12/21.
//

import Foundation

protocol URLMaking {
    func make(method: EndpointMethod) -> URL
}
