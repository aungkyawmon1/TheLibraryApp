//
//  LibraryViewModel.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 20/07/2565 BE.
//

import Foundation
import Combine

enum LibraryViewState {
    case success
    case failure(message: String)
}

class LibraryViewModel {
    private var bookModel: BookModelProtocol
    private var shelfModel: ShelfModelProtocol
    
    var bag = Set<AnyCancellable>()
    var viewState: PassthroughSubject<LibraryViewState, Never> = .init()
    var someValue: CurrentValueSubject<LibraryViewState, Never> = CurrentValueSubject<LibraryViewState, Never>(.failure(message: ""))
    private var wishlist = [WishlistVO]()
    private var shelves = [ShelfVO]()
    
    init(bookModel: BookModelProtocol, shelfModel: ShelfModelProtocol) {
        self.bookModel = bookModel
        self.shelfModel = shelfModel
    }
    
    func fetchWishlist(sort by: String) {
        bookModel.getWishlist(sort: by)
            .sink { data in
                self.wishlist = data
                self.viewState.send(.success)
                self.someValue.send(.success)
            }.store(in: &bag)
    }
    
    func getWishlistCount() -> Int {
        return wishlist.count
    }
    
    func getWishlist(at index: Int) -> BookVO {
        return wishlist[index].book ?? BookVO()
    }
    
    func getShelf() {
        shelfModel.getShelf()
            .sink { data in
                self.shelves = data
                self.viewState.send(.success)
               // self.someValue.send(.success)
            }.store(in: &bag)
    }
    
    func getShelfCount() -> Int {
        return shelves.count
    }
    
    func getShelf(at index: Int) -> ShelfVO {
        return shelves[index]
    }
}
