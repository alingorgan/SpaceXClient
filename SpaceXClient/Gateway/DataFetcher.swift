//
//  Gateway.swift
//
//  Created by Alin Gorgan on 5/12/21.
//

import Foundation

enum FetchError: Error {
    case cannotFetchData
    case cannotDecodeData
}

protocol DataFetching {
    func fetch<DataModel: Decodable>(endpointMethod: EndpointMethod,
                                     completion: @escaping (Result<DataModel, FetchError>) -> Void)
    
    func fetchRaw(externalURL: URL,
                  completion: @escaping (Result<Data, FetchError>) -> Void)
}

struct DataFetcher: DataFetching {
    let session = URLSession(configuration: .default)
    let urlFactory = SpaceXUrlFactory()
    
    func fetch<DataModel: Decodable>(
        endpointMethod: EndpointMethod,
        completion: @escaping (Result<DataModel, FetchError>) -> Void) {
        
        let url = urlFactory.make(method: endpointMethod)
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.cannotFetchData))
                return
            }
            
            guard let dataModel = try? JSONDecoder().decode(DataModel.self, from: data) else {
                completion(.failure(.cannotDecodeData))
                return
            }
            
            completion(.success(dataModel))
        }
        task.resume()
    }
    
    func fetchRaw(externalURL: URL, completion: @escaping (Result<Data, FetchError>) -> Void) {
        let request = URLRequest(url: externalURL)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.cannotFetchData))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
    
}
