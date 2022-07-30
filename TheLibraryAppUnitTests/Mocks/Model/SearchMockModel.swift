//
//  SearchMockModel.swift
//  TheLibraryAppUnitTests
//
//  Created by MacBook Pro on 27/07/2565 BE.
//

import Foundation
@testable import TheLibraryApp
import Combine

class SearchMockModel: SearchModelProtocol {
    
    func getBookListBySearch(with keyword: String) -> AnyPublisher<[BookVO], Never> {
        let searchJson: Data = try! Data(contentsOf: BookMockData.SearchList.search)
        let bookSearchResponseData: BookListSearchResponse = try! JSONDecoder().decode(BookListSearchResponse.self, from: searchJson)
        let subject = CurrentValueSubject<[BookVO], Never>([])
       
        if let items = bookSearchResponseData.items {
            let bookVO : [BookVO] = items.map {
                return $0.volumeInfo?.convertToBookVO() ?? BookVO()
            }
            subject.send(bookVO)
        }
        return subject.eraseToAnyPublisher()
        
    }
}
