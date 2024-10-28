//
//  DataSource.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Int)
}

protocol DataSource {
    func get<T: Decodable>(_ type: T.Type) -> AnyPublisher<T, Error>
}

class JSONReaderSource: DataSource {
    private let fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func get<T: Decodable>(_ type: T.Type) -> AnyPublisher<T, Error> {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return Fail(error: NSError(domain: "Bundle", code: 404, userInfo: nil))
                .eraseToAnyPublisher()
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

class ApiSource: DataSource {
    let apiURL: String
    
    init(apiURL: String) {
        self.apiURL = apiURL
    }
    
    func get<T: Decodable>(_ type: T.Type) -> AnyPublisher<T, Error> {
        
        guard let url = URL(string: apiURL) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.requestFailed(0)
                }
                
                guard 200...299 ~= httpResponse.statusCode else {
                    throw NetworkError.requestFailed(httpResponse.statusCode)
                }
                
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                }
                return error
            }
            .eraseToAnyPublisher()
    }
}

