//
//  ShowMoreViewModel.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 17/07/2565 BE.
//

import Foundation
import Combine

enum ShowMoreViewState {
    case success
    case failure(message: String)
}

class ShowMoreViewModel {
    private var bookModel: BookModelProtocol
    private let listID : Int
    private let listNameEncoded : String
    private var bag = Set<AnyCancellable>()
    private var books = [BookVO]()
    var viewState: PassthroughSubject<ShowMoreViewState, Never> = .init()
    
    init(bookModel: BookModel, listID: Int, listNameEncoded: String){
        self.bookModel = bookModel
        self.listID = listID
        self.listNameEncoded = listNameEncoded
    }
    
    func fetchData() {
        bookModel.getBookListByListName(id: listID, listName: listNameEncoded)
            .sink { data in
                self.books = data
                self.viewState.send(.success)
            }.store(in: &bag)
    }
    
    func getBookCount() -> Int {
        return books.count
    }
    
    func getBook(with id: Int) -> BookVO {
        return books[id]
    }
    
}
