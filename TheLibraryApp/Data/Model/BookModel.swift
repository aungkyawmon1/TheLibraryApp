//
//  BookModel.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 10/07/2565 BE.
//

import Foundation
import Combine
import RealmSwift

protocol BookModelProtocol {
    func getBookListOverview()  -> AnyPublisher<[ListVO], Never>
    func getRecentlyDetailedBooks() -> AnyPublisher<[RecentDetailVO], Never>
    func saveRecentlyDetailedbooks(data: RecentDetailVO)
    func getBookListByListName(id: Int, listName: String) -> AnyPublisher<[BookVO], Never>
    func getWishlist(sort by: String) -> AnyPublisher<[WishlistVO], Never>
    func isInWishListByID(with bookVO: BookVO) -> Bool
    func addToWishlist(with bookVO : BookVO) -> Bool
    func removeFromWishlist(with bookVO: BookVO) -> Bool
}

class BookModel: BaseModel, BookModelProtocol {
    
    
    static let shared = BookModel()
    var bag = Set<AnyCancellable>()
    private let bookRepository: BookProtocol = BookRepository.shared
    private override init() { }
    
    func getBookListOverview()  -> AnyPublisher<[ListVO], Never> {
        networkAgent.getBookList().sink { networkError in
            debugPrint(networkError)
        } receiveValue: { data in
            if let results = data.results, let bookList = results.lists {
                self.bookRepository.saveBookCollection(data: bookList)
            }
            
        }.store(in: &bag)

    
        return bookRepository.getBookCollection()
    }
    
    func getBookListByListName(id: Int, listName: String) -> AnyPublisher<[BookVO], Never> {
        networkAgent.getBooksByListName(listName: listName)
            .sink { networkerror in
                debugPrint(networkerror)
            } receiveValue: { data in
                debugPrint("list")
                if let results = data.results, let books = results.books {
                    self.bookRepository.saveBookCollectionByListID(id: id, data: books)
                }
            }.store(in: &bag)
        
        return bookRepository.getBookCollectionByListID(id: id)

    }
    
    func getRecentlyDetailedBooks() -> AnyPublisher<[RecentDetailVO], Never> {
        return bookRepository.getRecentlyDetailedBook()
    }
    
    func saveRecentlyDetailedbooks(data: RecentDetailVO) {
        bookRepository.saveRecentlyDetailedBook(data: data)
    }
    
    func getWishlist(sort by: String) -> AnyPublisher<[WishlistVO], Never> {
        return bookRepository.getWishList(sort: by)
    }
    
    func isInWishListByID(with bookVO: BookVO) -> Bool {
        return bookRepository.isInWishlistByID(with: bookVO)
    }
    
    func addToWishlist(with bookVO : BookVO) -> Bool {
        return bookRepository.addToWishlist(with: bookVO)
    }
    func removeFromWishlist(with bookVO: BookVO) -> Bool {
        return bookRepository.removeFromWishlist(with: bookVO)
    }
    
}
