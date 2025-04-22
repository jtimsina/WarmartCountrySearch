//
//  NetworkManager.swift
//  WarmartCountrySearch
//
//  Created by Jai Timsina on 4/22/25.
//

import Foundation

protocol NetworkActions{
    func fetchCountries<T:Decodable>(urlString: String, modelType:T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkManager {
    let urlsession: URLSession

    init(urlsession: URLSession = .shared) {
        self.urlsession =  urlsession
    }
    
}

extension NetworkManager:NetworkActions{
    func fetchCountries<T:Decodable>(urlString: String, modelType:T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let countries = try JSONDecoder().decode(modelType.self, from: data)
                completion(.success(countries))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
