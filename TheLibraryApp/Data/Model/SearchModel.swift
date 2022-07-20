//
//  SearchModel.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 18/07/2565 BE.
//

import Foundation
import Combine

protocol SearchModelProtocol {
    func getBookListBySearch(with keyword: String) -> AnyPublisher<[BookVO], Never>
}

class SearchModel: BaseModel, SearchModelProtocol {
    
    static let shared = SearchModel()
    private var bag = Set<AnyCancellable>()
    private override init() { }
    
    func getBookListBySearch(with keyword: String) -> AnyPublisher<[BookVO], Never> {
        
        let subject = CurrentValueSubject<[BookVO], Never>([])
        networkAgent.getBooksBySearch(with: keyword)
            .sink { error in
                debugPrint(error)
            } receiveValue: { data in
                if let items = data.items {
                    let bookVO : [BookVO] = items.map {
                        return $0.volumeInfo?.convertToBookVO() ?? BookVO()
                    }
                    subject.send(bookVO)
                }
            }.store(in: &bag)
        
        return subject.eraseToAnyPublisher()

    }
    
}
