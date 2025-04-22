//
//  MockNetworkManager.swift
//  WarmartCountrySearchTests
//
//  Created by Jai Timsina on 4/22/25.
//

import Foundation
@testable import WarmartCountrySearch

class MockNetworkManager: NetworkActions {
    func fetchCountries<T>(urlString: String, modelType: T.Type, completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
        
        let bundle = Bundle(for: MockNetworkManager.self)
        if urlString.isEmpty{
            completion(.failure(NetworkError.invalidURL))
            return
        }
        guard let path = bundle.url(forResource: urlString, withExtension: "json")else{
            completion(.failure(NetworkError.invalidURL))
            return
        }
        do{
            let data = try Data(contentsOf: path)
            let countries = try JSONDecoder().decode(modelType.self, from: data)
            completion(.success(countries))
        }catch{
            completion(.failure(NetworkError.noData))
        }
        
    }
    
    
}
