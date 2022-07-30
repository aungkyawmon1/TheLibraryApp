//
//  NetworkClientTest.swift
//  TheLibraryAppUnitTests
//
//  Created by MacBook Pro on 27/07/2565 BE.
//

import XCTest
@testable import TheLibraryApp
import Mocker
import Alamofire
import Combine

class NetworkClientTest: XCTestCase {

    let networkClient = BookNetworkAgent.shared
    var bag : Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        //Setting to dependency
        let sessionManager = Session(configuration: configuration)
        networkClient.sessionManager = sessionManager
        bag = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_searchBook_successWithValidResponse_returnCorrectData() throws {
        let q = "flutter"
        let urlString = q.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let searchUrl = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(urlString ?? "")")!
        
        let searchBookExpection = expectation(description: "wait for search book")
        //Load Data from json file
        let mockedDataFromJSON = try! Data(contentsOf: BookMockData.SearchList.search)
        
        let mock = Mock(url: searchUrl, dataType: .json, statusCode: 200, data: [.get: mockedDataFromJSON])
        mock.register()
        
        networkClient.getBooksBySearch(with: q)
            .sink { error in
                //XCTFail("Shouldn't fail with \(error)")
            } receiveValue: { data in
                XCTAssertGreaterThan(data.totalItems ?? 0, 0)
                searchBookExpection.fulfill()
            }.store(in: &bag)
        
        wait(for: [searchBookExpection], timeout: 10)

    }
    
    func test_bookOverview_successWithValidResponse_returnCorrectData() throws {
        let apiEndpoint = BookEndpoint.overview.url
        
        let bookExpection = expectation(description: "wait for search movie")
        
        let mockedDataFromJSON = try! Data(contentsOf: BookMockData.BookList.overview)
        
        let mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: mockedDataFromJSON])
        mock.register()
        
        networkClient.getBookList()
            .sink { error in
                //XCTFail("error \(error)")
            } receiveValue: { data in
                XCTAssertGreaterThan(data.numResults ?? 0, 0)
                bookExpection.fulfill()
            }.store(in: &bag)
        
        wait(for: [bookExpection], timeout: 10)

    }
    
    func test_bookOverview_withInvalidApiKey_returnInError() throws {
        let apiEndpoint = URL(string: "https://api.nytimes.com/svc/books/v3/lists/overview.json?api-key=40303930")!
        
        let bookExpection = expectation(description: "wait for search movie")
        //Load Data from json file
        let mockedDataFromJSON = try! Data(contentsOf: BookMockData.BookList.noApiKey)
        
        let mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: mockedDataFromJSON])
        mock.register()
        
        networkClient.getBookList()
            .sink { error in
                XCTAssertNotNil(error)
                bookExpection.fulfill()
            } receiveValue: { _ in
                XCTFail("Should not return data")
            }.store(in: &bag)

        wait(for: [bookExpection], timeout: 10)
    }

}
