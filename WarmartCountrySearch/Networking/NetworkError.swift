//
//  NetworkError.swift
//  WarmartCountrySearch
//
//  Created by Jai Timsina on 4/22/25.
//

import Foundation

enum NetworkError: Error , LocalizedError, Equatable {
    case errorWhileParsing
    case invalidURL
    case noResponse
    case noData
    case timeOutError
    
    
    static func getNetwork(error: Error) -> NetworkError {
        switch error {
        case is DecodingError:
            return NetworkError.errorWhileParsing
        case is URLError:
            return .invalidURL
        case NetworkError.noData:
            return NetworkError.noData
        case NetworkError.noResponse:
            return NetworkError.noResponse
        case NetworkError.timeOutError:
            return NetworkError.timeOutError
        default:
            return .noData
        }
    }
    
    var errorDescription: String? {
        let networkError: String
        switch self {
        case .invalidURL:
            networkError = NSLocalizedString("Invalid API Link", comment: "invalidUrlError")
        case .noData:
            networkError = NSLocalizedString("No Response from API", comment: "dataNotFoundError")
        case .errorWhileParsing:
            networkError = NSLocalizedString("Data parsing issue", comment: "parsingError")
        case .noResponse:
            networkError = NSLocalizedString("No Response", comment: "noResponse")
        case .timeOutError:
            networkError = NSLocalizedString("Time ran out.", comment: "timeOutError")
        }
        return networkError
    }
}

