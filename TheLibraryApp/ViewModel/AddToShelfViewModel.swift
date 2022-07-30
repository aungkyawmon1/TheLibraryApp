//
//  AddToShelfViewModel.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 21/07/2565 BE.
//

import Foundation
import Combine

enum AddToShelfState {
    case noShelf
    case shelvesExist
    case success
    case failure
}

class AddToShelfViewModel {
    private var bag = Set<AnyCancellable>()
    var viewState: PassthroughSubject<AddToShelfState, Never> = .init()
    
    private var shelves = [ShelfVO]()
    private var book : BookVO
    private var shelfModel : ShelfModelProtocol
    
    init(shelfModel: ShelfModel, book: BookVO){
        self.shelfModel = shelfModel
        self.book = book
    }
    
    var bookTitle: String? {
        get {
            return book.title
        }
    }
    
    func getShelf() {
        shelfModel.getShelf()
            .sink { data in
                if data.count == 0 {
                    self.viewState.send(.noShelf)
                }else {
                    self.shelves = data
                    self.viewState.send(.shelvesExist)
                }
            }.store(in: &bag)
    }
    
    func saveShelfBook(shelf: ShelfVO) {
        
        if shelfModel.saveShelfBook(shelf: shelf, bookVO: book)  {
            viewState.send(.success)
        }
    }
    
    func getShelfTitle(with index: Int) -> String {
        return shelves[index].shelfTitle
    }
    
    func getNumberOfShelf() -> Int {
        return shelves.count
    }
    
    func getShelfAtIndex(with index: Int) -> ShelfVO {
        return shelves[index]
    }
    
    func isInShelfBook(with id : Int) -> Bool {
        let id = "\(book.primaryIsbn13 ?? "")\(shelves[id].shelfTitle)"
        return shelfModel.isInShelfBook(id: id)
    }
    
}
