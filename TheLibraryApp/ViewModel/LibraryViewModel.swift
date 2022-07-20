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
    var bag = Set<AnyCancellable>()
    var viewState: PassthroughSubject<LibraryViewState, Never> = .init()
    private var wishlist = [WishlistVO]()
    
    init(bookModel: BookModel) {
        self.bookModel = bookModel
    }
    
    func fetchWishlist(sort by: String) {
        bookModel.getWishlist(sort: by)
            .sink { data in
                self.wishlist = data
                self.viewState.send(.success)
            }.store(in: &bag)
    }
    
    func getWishlistCount() -> Int {
        return wishlist.count
    }
    
    func getWishlist(at index: Int) -> BookVO {
        return wishlist[index].book ?? BookVO()
    }
    
    
    
}
