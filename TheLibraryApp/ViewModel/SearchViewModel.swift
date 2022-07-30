//
//  SearchViewModel.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 18/07/2565 BE.
//

import Foundation
import Combine

enum SearchViewState {
    case success
    case failure(message: String)
}

class SearchViewModel {
    private var searchModel: SearchModelProtocol
    private var bag = Set<AnyCancellable>()
    private var books = [BookVO]()
    var viewState: PassthroughSubject<SearchViewState, Never> = .init()
    var someValue: CurrentValueSubject<SearchViewState, Never> = CurrentValueSubject<SearchViewState, Never>(.failure(message: ""))
    init(searchModel: SearchModelProtocol){
        self.searchModel = searchModel
    }
    
    
    
    func fetchData(with keyword: String) {
        searchModel.getBookListBySearch(with: keyword)
            .sink { data in
                self.books = data
                self.viewState.send(.success)
                self.someValue.send(.success)
            }.store(in: &bag)
    }
    
    func getBookCount() -> Int {
        return books.count
    }
    
    func getBook(with id: Int) -> BookVO {
        return books[id]
    }
    
}
