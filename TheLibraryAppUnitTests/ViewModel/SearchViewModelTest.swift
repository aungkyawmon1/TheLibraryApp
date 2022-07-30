//
//  SearchViewModelTest.swift
//  TheLibraryAppUnitTests
//
//  Created by MacBook Pro on 27/07/2565 BE.
//

@testable import TheLibraryApp
import Combine
import XCTest

class SearchViewModelTest: XCTestCase {
    var searchModel: SearchMockModel!
    var viewModel: SearchViewModel!
    var bag: Set<AnyCancellable>!
    
    
    override func setUpWithError() throws {
        searchModel = SearchMockModel()
        viewModel = SearchViewModel(searchModel: searchModel)
        bag = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        searchModel = nil
        viewModel = nil
    }
    
    func test_searchBook_allDataExist_returnsAllItems() throws {
        let responseExpectation = expectation(description: "wait for response")
        
        viewModel.fetchData(with: "flutter")
        viewModel.someValue
            .sink { state in
                if case .success = state {
                    XCTAssertGreaterThan(self.viewModel.getBookCount(), 0)
                    responseExpectation.fulfill()
                }
            }.store(in: &bag)
        
        wait(for: [responseExpectation], timeout: 10)
    }
}
