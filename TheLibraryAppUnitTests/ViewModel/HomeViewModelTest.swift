//
//  HomeViewModelTest.swift
//  TheLibraryAppUnitTests
//
//  Created by MacBook Pro on 26/07/2565 BE.
//

import XCTest
@testable import TheLibraryApp
import Combine

class HomeViewModelTest: XCTestCase {

    var bookModel: BookMockModel!
    var viewModel: HomeViewModel!
    var bag: Set<AnyCancellable>!
    
    
    override func setUpWithError() throws {
        bookModel = BookMockModel()
        viewModel = HomeViewModel(bookModel: bookModel)
        bag = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        bookModel = nil
        viewModel = nil
        
    }

    func test_fetchBookList_allDataExist_returnsAllItems() throws {
        let responseExpectation = expectation(description: "wait for response")
        
        let recentDetailVO = RecentDetailVO()
        recentDetailVO.primaryIsbn13 = "9292002"
        recentDetailVO.recentlyDate = Date()
        
        bookModel.saveRecentlyDetailedbooks(data: recentDetailVO)
        viewModel.fetchBookList()
        viewModel.fetchRecentDetailedBook()
        
        self.viewModel.someValue
            .sink { state in
                switch state {
                case .success(type: let type):
                    switch type{
                    case .RecentlyOpenedItems(items: let items):
                        XCTAssertGreaterThan(items.count, 0)
                    case .CategorySelection:
                        XCTFail("fail")
                    case .ItemList(items: let items):
                        XCTAssertGreaterThan(items.count, 0)
                        responseExpectation.fulfill()
                    }
                case .failure(message: let message):
                    XCTFail("Shouldn't fail \(message)")
                    
                }}.store(in: &bag)
        wait(for: [responseExpectation], timeout: 10)
    }
    
    func test_fetchBookList_recentlyDetailedBook_returnsRecentlyDetailedBook() throws {
        let responseExpectation = expectation(description: "wait for response")
        
        let recentDetailVO = RecentDetailVO()
        recentDetailVO.primaryIsbn13 = "9292002"
        recentDetailVO.recentlyDate = Date()
        
        viewModel.fetchRecentDetailedBook()
        
        self.viewModel.viewState
            .sink { state in
                switch state {
                case .success(type: let type):
                    switch type {
                    case .RecentlyOpenedItems(items: let items):
                        XCTAssertGreaterThan(items.count, 0)
                        responseExpectation.fulfill()
                    default:
                        XCTFail("Shouldn't faile")
                    }
                case .failure(message: let message):
                    XCTFail(message)
                }
            }.store(in: &bag)
        
        wait(for: [responseExpectation], timeout: 5)
    }
    
    func test_fetchBookList_overviewBook_returnsOverviewBook() throws {
        let responseExpectation = expectation(description: "wait for response")
        
        viewModel.fetchBookList()
        
        self.viewModel.someValue
            .sink { state in
                switch state {
                case .success(type: let type):
                    switch type {
                    case .ItemList(items: let items):
                        XCTAssertGreaterThan(items.count, 0)
                        responseExpectation.fulfill()
                    default:
                        XCTFail("Shouldn't faile")
                    }
                case .failure(message: let message):
                    XCTFail(message)
                }
            }.store(in: &bag)
        
        wait(for: [responseExpectation], timeout: 5)
    }
    
    func testExample() throws {
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
