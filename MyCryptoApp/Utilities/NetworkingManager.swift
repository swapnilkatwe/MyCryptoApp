//
//  NetworkingManager.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 12/04/24.
//

import Foundation
import Combine

enum NetworkingError: LocalizedError {
    case badUrlResponse(url: URL)
    case unknown
    var errorDescription: String? {
        switch self {
        case .badUrlResponse(url: let url):
            return "[♨️] Bad response from URL: \(url)"
        case .unknown:
            return "[‼️] Unknown error occured"
        }
    }
}

class NetworkingManager {
    
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
        
       return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleUrlResponse(output: $0, url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher() // This will erase uncessesory publisher and makes return type to AnyPublisher<Data, any Error> which is copy pasted in functions return type
        
    }
    
    static func handleUrlResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badUrlResponse(url: url)
        }
        return output.data
    }

    static func handleCompletion(completion: Subscribers.Completion<any Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}


// Subscribers.Completion<any Publishers.Decode<AnyPublisher<Data, any Error>, [CoinModel], JSONDecoder>.Failure>
