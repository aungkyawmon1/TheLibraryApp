//
//  LibraryViewModelTest.swift
//  TheLibraryAppUnitTests
//
//  Created by MacBook Pro on 28/07/2565 BE.
//

import XCTest
@testable import TheLibraryApp
import Combine

class LibraryViewModelTest: XCTestCase {

    var bookModel : BookModelProtocol!
    var shelfModel : ShelfModelProtocol!
    var viewModel: LibraryViewModel!
    var bag: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        bookModel = BookMockModel()
        shelfModel = ShelfMockModel()
        viewModel = LibraryViewModel(bookModel: bookModel, shelfModel: shelfModel)
        bag = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        bookModel = nil
        shelfModel = nil
        viewModel = nil
    }

    func test_fetchAll_allDataExist_returnsAllData() throws {
        let responseExpectation = expectation(description: "wait for response")

        let shelf = ShelfVO()
        shelf.id = "id"
        shelf.shelfTitle = "aa"
        shelf.recentlyDate = Date()
        _ = shelfModel.saveShelf(shelf: shelf)
        
         let book = BookVO()
         book.primaryIsbn13 = "1"
         book.title = "flutter"
         book.author = "Elon"
         let value = bookModel.addToWishlist(with: book)
         debugPrint(value)
        
        viewModel.fetchWishlist(sort: "title")
        viewModel.getShelf()
        
        viewModel.someValue
            .sink { state in
                if case .success = state {
              
                    XCTAssertGreaterThan(self.viewModel.getShelfCount(), 0)
                    XCTAssertGreaterThan(self.viewModel.getWishlistCount(), 0)
                    responseExpectation.fulfill()
                }
            }.store(in: &bag)
        
        wait(for: [responseExpectation], timeout: 10)
        
    }
    
    func test_fetchShelf_dataExist_returnsSuccess() throws {
        
        let responseExpectation = expectation(description: "wait for response")
        let shelf = ShelfVO()
        shelf.id = "i1"
        shelf.shelfTitle = "aa"
        shelf.recentlyDate = Date()
        _ = shelfModel.saveShelf(shelf: shelf)
        
        viewModel.getShelf()
        
        viewModel.someValue
            .sink { state in
                if case .success = state {
                    XCTAssertGreaterThan(self.viewModel.getShelfCount(), 0)
                    responseExpectation.fulfill()
                }
            }.store(in: &bag)
        
        wait(for: [responseExpectation], timeout: 10)
    }
    
    
    func test_fetchWishList_dataExist_returnsSuccess() throws {
        let responseExpectation = expectation(description: "wait for response")
        
         let book = BookVO()
         book.primaryIsbn13 = "1"
         book.title = "flutter"
         book.author = "Elon"
         let value = bookModel.addToWishlist(with: book)
        
        viewModel.fetchWishlist(sort: "title")
        
        viewModel.someValue
            .sink { state in
                if case .success = state {
                    XCTAssertGreaterThan(self.viewModel.getWishlistCount(), 0)
                    responseExpectation.fulfill()
                }
            }.store(in: &bag)
        
        wait(for: [responseExpectation], timeout: 10)
    }
    
    

    func testPerformanceExample() throws {
        self.measure { }
    }

}
