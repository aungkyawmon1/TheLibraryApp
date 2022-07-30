//
//  NetworkAgentWithAlamofire.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 06/07/2022.
//

import Foundation
import Alamofire
import Combine

protocol BookNetworkAgentProtocol {
    func getBookList() -> AnyPublisher<BookListResponse, AFError>
    func getBooksByListName(listName: String) -> AnyPublisher<BookListByListNameResponse, AFError>
    func getBooksBySearch(with keyword: String) -> AnyPublisher<BookListSearchResponse, AFError> 
}

class BookNetworkAgent: BookNetworkAgentProtocol {
    
    static let shared = BookNetworkAgent()
    var sessionManager: Session = AF
    func getBookList() -> AnyPublisher<BookListResponse, AFError> {
        return sessionManager.request(BookEndpoint.overview).publishDecodable(type: BookListResponse.self).value()
    }
    
    func getBooksByListName(listName: String) -> AnyPublisher<BookListByListNameResponse, AFError> {
        return sessionManager.request(BookEndpoint.listName(listNameEncoded: listName)).publishDecodable(type: BookListByListNameResponse.self).value()
    }
    
    func getBooksBySearch(with keyword: String) -> AnyPublisher<BookListSearchResponse, AFError> {
        let urlString = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return sessionManager.request(URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(urlString ?? "")")!).publishDecodable(type: BookListSearchResponse.self).value()
    }
}

