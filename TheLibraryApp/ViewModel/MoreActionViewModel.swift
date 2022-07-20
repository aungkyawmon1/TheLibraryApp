//
//  MoreActionViewModel.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 20/07/2565 BE.
//

import Foundation
import Combine


enum MoreActionState {
    case succes(message: String)
    case failure(message: String)
}

class MoreActionViewModel {
    
    private var bookModel: BookModelProtocol
    private var bookVO: BookVO
    var bag = Set<AnyCancellable>()
    var viewState: PassthroughSubject<LibraryViewState, Never> = .init()
    private var wishlist = [WishlistVO]()
    
    init(bookModel: BookModel, bookVO: BookVO) {
        self.bookModel = bookModel
        self.bookVO = bookVO
    }
    
    var title : String? {
        get {
            return bookVO.title
        }
    }
    
    var author : String? {
        get {
            return bookVO.author
        }
    }
    
    var bookCover : String {
        get {
            return bookVO.bookImage ?? ""
        }
    }
    
    var book : BookVO {
        get {
            return bookVO
        }
    }
    
    func isInWishlist() -> Bool {
        return bookModel.isInWishListByID(with: bookVO)
    }
    
    func addToWishlist() -> Bool {
        return bookModel.addToWishlist(with: bookVO)
    }
    
    func removeFromWishlist() -> Bool {
        return bookModel.removeFromWishlist(with: bookVO)
    }
    
}
