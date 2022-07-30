//
//  BookDetailViewModel.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 21/07/2565 BE.
//

import Foundation
import Combine

enum BookDetailState {
    case bookAction
}

class BookDetailViewModel {
    
    private var bookModel: BookModelProtocol
    private var bookVO: BookVO
    private var wishlist = [WishlistVO]()
    
    var bag = Set<AnyCancellable>()
    var viewState: PassthroughSubject<BookDetailState, Never> = .init()
    var items = [BookDetailSectionType]()
   
    init(bookModel: BookModel, bookVO: BookVO) {
        self.bookModel = bookModel
        self.bookVO = bookVO
        items = [
            .bookInfo(image: bookVO.bookImage ?? "", title: bookVO.title ?? "", author: bookVO.author ?? ""),
            .bookActionItem(isInWishlist: false),
            .aboutBook(description: bookVO.bookDescription ?? "" ),
            .ratingAndReviews,
            .comments(comment: [
                Comment(comment: "It's June 2022 , Who can suddenly remember & how many legends still listening this Masterpiece"),
                Comment(comment: "I think this song somewhat aligns with the time we all have missed since the pandemic started. I hope someday we all get to sit down all together, get to do the things we used to do pre pandemic and everything. I hope you all are still having a good day. This is a nice song. This song is only showing good vibes. Love it.")
            ]),
            .published
        ]
        
    }
    
    func notifyBookActionItem(isInWishlist: Bool) {
        items[1] = .bookActionItem(isInWishlist: isInWishlist)
        viewState.send(.bookAction)
    }
    
    func saveToRecentlyDetailedBook() {
        let recentlyDetailedBook = RecentDetailVO()
        recentlyDetailedBook.primaryIsbn13 = bookVO.primaryIsbn13
        recentlyDetailedBook.recentlyDate = Date()
        recentlyDetailedBook.book = bookVO
        bookModel.saveRecentlyDetailedbooks(data: recentlyDetailedBook)
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
    
    func getItemCount() -> Int {
        return items.count
    }
    
    func getItemSection(_ section: Int) -> BookDetailSectionType {
        return items[section]
    }
    
    func getNubmerOfRowInSection(sectionType: BookDetailSectionType) -> Int {
        switch sectionType {
        case .comments(let comments):
            return comments.count
        default:
            return 1
        }
    }
    
}
