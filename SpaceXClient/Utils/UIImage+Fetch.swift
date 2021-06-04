//
//  UIImage+Fetch.swift
//  SpaceXClient
//
//  Created by Alin Gorgan on 6/4/21.
//

import UIKit

extension UIImage {
    static func loadImage(from stringUrl: String,
                          completion: @escaping (UIImage?, UUID) -> Void) -> UUID {
        let dataFetcher = DataFetcher()
        let sessionId = UUID()
        
        guard let url = URL(string: stringUrl) else {
            completion(nil, sessionId)
            return sessionId
        }
        
        dataFetcher.fetchRaw(externalURL: url) { result in
            guard case .success(let data) = result else {
                completion(nil, sessionId)
                return
            }
            DispatchQueue.main.async {
                completion(UIImage(data: data), sessionId)
            }
        }
        
        return sessionId
    }
}
