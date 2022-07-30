//
//  BookMockModel.swift
//  TheLibraryAppUnitTests
//
//  Created by MacBook Pro on 26/07/2565 BE.
//

import Foundation
@testable import TheLibraryApp
import Combine

class BookMockModel: BookModelProtocol {
    
    let bookRepository = BookRepository.shared
    init() {
        
    }
    
    func getBookListOverview() -> AnyPublisher<[ListVO], Never> {
        debugPrint("test")
        let overviewJson: Data = try! Data(contentsOf: BookMockData.BookList.overview)
        let bookResponseData: BookListResponse = try! JSONDecoder().decode(BookListResponse.self, from: overviewJson)
        var bookTitles = [ListVO]()
        if let results = bookResponseData.results, let bookList = results.lists {
            bookList.forEach { bookList in
                let listVO = bookList.convertToBookVO()
                
                listVO.books.append(objectsIn: bookList.books?.map({ book in
                    let bookVO = book.convertToBookVO()
                    var count = 1
                    bookVO.buyLinks.append(objectsIn: book.buyLinks?.map({ buyLink in
                        let link = buyLink.convertToBuyLink()
                        link.id = "\(count)\(bookVO.primaryIsbn13 ?? "")"
                        count += 1
                        return link
                    }) ?? [] )
                    return bookVO
                }) ?? [BookVO]() )
                
                bookTitles.append(listVO)
            }
        }
        
        let subject = CurrentValueSubject<[ListVO], Never>([])
        subject.send(bookTitles)
        return subject.eraseToAnyPublisher()
        
    }
    
    func getRecentlyDetailedBooks() -> AnyPublisher<[RecentDetailVO], Never> {
        return bookRepository.getRecentlyDetailedBook()
    }
    
    func saveRecentlyDetailedbooks(data: RecentDetailVO) {
        
    }
    
    func getBookListByListName(id: Int, listName: String) -> AnyPublisher<[BookVO], Never> {
        return Empty(completeImmediately: true).eraseToAnyPublisher()
    }
    
    func getWishlist(sort by: String) -> AnyPublisher<[WishlistVO], Never> {
        bookRepository.getWishList(sort: by)
    }
    
    func isInWishListByID(with bookVO: BookVO) -> Bool {
        return false
    }
    
    func addToWishlist(with bookVO: BookVO) -> Bool {
        bookRepository.addToWishlist(with: bookVO)
    }
    
    func removeFromWishlist(with bookVO: BookVO) -> Bool {
        return false
    }
    
    
}
