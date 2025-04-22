//
//  CountryViewModel.swift
//  WarmartCountrySearch
//
//  Created by Jai Timsina on 4/22/25.
//

import Foundation

class CountryViewModel {
    private var allCountries: [Country] = []
    var filteredCountries: [Country] = []
    var error: NetworkError?
    var onError: ((String) -> Void)?
    var onDataUpdated: (() -> Void)?
    
    private let netowrkManager: NetworkActions
    
    init(netowrkManager: NetworkActions) {
        self.netowrkManager = netowrkManager
    }
    
    func fetchCountries(urlString: String) {
        self.netowrkManager.fetchCountries(urlString: urlString, modelType:[Country].self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let countries):
                    self?.allCountries = countries
                    self?.filteredCountries = countries
                    self?.onDataUpdated?()
                case .failure(let error):
                    switch error{
                    case is DecodingError:
                        self?.onError?(NetworkError.errorWhileParsing.localizedDescription)
                        self?.error = NetworkError.errorWhileParsing
                    case is URLError:
                        self?.onError?(NetworkError.invalidURL.localizedDescription)
                        self?.error = NetworkError.invalidURL
                    case NetworkError.invalidURL:
                        self?.onError?(NetworkError.invalidURL.localizedDescription)
                        self?.error = NetworkError.invalidURL
                    case NetworkError.noData:
                        self?.onError?(NetworkError.noData.localizedDescription)
                        self?.error = NetworkError.noData
                    case NetworkError.errorWhileParsing:
                        self?.onError?(NetworkError.errorWhileParsing.localizedDescription)
                        self?.error = NetworkError.errorWhileParsing
                    case NetworkError.noResponse:
                        self?.onError?(NetworkError.noResponse.localizedDescription)
                        self?.error = NetworkError.noResponse
                    default:
                        self?.error = NetworkError.noData
                        self?.onError?(error.localizedDescription)
                    }
                }
            }
        }
    }
}

extension CountryViewModel{
    func filterCountries(searchText: String) {
        if searchText.isEmpty {
            filteredCountries = allCountries
        } else {
            filteredCountries = allCountries.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.capital.lowercased().contains(searchText.lowercased())
            }
        }
        onDataUpdated?()
    }
}
