//
//  WarmartCountrySearchTests.swift
//  WarmartCountrySearchTests
//
//  Created by Jai Timsina on 4/22/25.
//

import XCTest
@testable import WarmartCountrySearch

final class WarmartCountrySearchTests: XCTestCase {
    
    var viewModel: CountryViewModel!
    var mockManager: MockNetworkManager!

    override func setUpWithError() throws {
        super.setUp()
        mockManager = MockNetworkManager()
        viewModel = CountryViewModel(netowrkManager: mockManager)
    }

    override func tearDownWithError() throws {
        super.tearDown()
        viewModel = nil
        
    }

    func testFetchCountries_WhenExpctingCorrectData() {
        let expectation = XCTestExpectation(description: "Fetch countries from API")
        
        viewModel.fetchCountries(urlString:"CountriesTest")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertFalse(self.viewModel.filteredCountries.count == 0, "Country is not Empty")
            XCTAssertEqual(self.viewModel.filteredCountries.count,4)

            let firstCountry = self.viewModel.filteredCountries.first
            XCTAssertEqual(firstCountry?.name,"Afghanistan")
            XCTAssertEqual(firstCountry?.capital,"Kabul")
            XCTAssertEqual(firstCountry?.code,"AF")
            XCTAssertEqual(firstCountry?.region,"AS")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchCountries_WhenExpectingParsingIsuse() {
        let expectation = XCTestExpectation(description: "Fetch countries from API, but Expecting data Parsing Isuse")
        
        viewModel.fetchCountries(urlString:"CountriesTestWithParssingError")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.viewModel.filteredCountries.count,0)
            XCTAssertEqual(self.viewModel.error,NetworkError.noData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchCountries_WhenExpectingNoDataWhenUrlIsEmpty() {
        let expectation = XCTestExpectation(description: "Fetch countries from API, but Expecting No data becuase url is empty")
        
        viewModel.fetchCountries(urlString:"")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.viewModel.filteredCountries.count,0)
            XCTAssertEqual(self.viewModel.error,NetworkError.invalidURL)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    // MARK: - Filter Tests
    func testFilterCountries_WhenExpctingCorrectData() {
        let expectation = XCTestExpectation(description: "correct serach functionality")
        
        viewModel.fetchCountries(urlString:"CountriesTest")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.viewModel.filteredCountries.count,4)

            self.viewModel.filterCountries(searchText: "Kabul")
            XCTAssertEqual(self.viewModel.filteredCountries.count,1)

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testFilterCountries_WhenExpctingSearchtextIsEmpty() {
        let expectation = XCTestExpectation(description: "test serach functionality, for empty serach string")
        
        viewModel.fetchCountries(urlString:"CountriesTest")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.viewModel.filteredCountries.count,4)

            self.viewModel.filterCountries(searchText: "")
            XCTAssertEqual(self.viewModel.filteredCountries.count,4)

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
