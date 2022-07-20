//
//  BookRepository.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 12/07/2565 BE.
//

import Foundation
import RealmSwift
import Combine

protocol BookProtocol {
    func saveBookCollection(data: [BookList])
    func saveBookCollectionByListID(id: Int,data: [Book])
    func saveRecentlyDetailedBook(data: RecentDetailVO)
    func getBookCollection() -> AnyPublisher<[ListVO], Never>
    func getRecentlyDetailedBook() -> AnyPublisher<[RecentDetailVO], Never>
    func getBookCollectionByListID(id: Int) -> AnyPublisher<[BookVO], Never>
    func getWishList(sort by: String)  -> AnyPublisher<[WishlistVO], Never>
    func isInWishlistByID(with bookVO: BookVO) -> Bool
    func addToWishlist(with bookVO : BookVO) -> Bool
    func removeFromWishlist(with bookVO: BookVO) -> Bool
}

class BookRepository: BaseRepository, BookProtocol {

    static let shared : BookProtocol = BookRepository()
    var notificationToken1: NotificationToken?
    var notificationToken2: NotificationToken?
    var notificationToken3: NotificationToken?
    var notificationToken4: NotificationToken?
    private override init() { }
    
    func saveBookCollection(data: [BookList]) {
        let listCategories = realmInstance.objects(ListVO.self)
        var bookTitles = [ListVO]()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        if listCategories.count != data.count {
            data.forEach { bookList in
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
            
            do {
                try realmInstance.write {
                    realmInstance.add(bookTitles, update: .modified)
                }
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func saveRecentlyDetailedBook(data: RecentDetailVO) {
        do {
            try realmInstance.write {
                realmInstance.add(data, update: .modified)
            }
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func getBookCollection() -> AnyPublisher<[ListVO], Never> {
        let listVO = realmInstance.objects(ListVO.self)
        
        let subject = CurrentValueSubject<[ListVO], Never>([])
        subject.send(Array(listVO))
        
       
        notificationToken1 = listVO.observe { [weak self] changes in
            guard let _ = self else { return }
            switch changes {
            case .update(let vo, deletions: _, insertions: _, modifications: _):
                subject.send(Array(vo))
            default:
                debugPrint("Hello")
            }
      
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    func getRecentlyDetailedBook() ->  AnyPublisher<[RecentDetailVO], Never> {
        let bookObjects = realmInstance.objects(RecentDetailVO.self).sorted(byKeyPath: "recentlyDate", ascending: false)
        
        let subject = CurrentValueSubject<[RecentDetailVO], Never>([])
        subject.send(Array(bookObjects))
        
       
        notificationToken2 = bookObjects.observe { [weak self] changes in
            guard let _ = self else { return }
            switch changes {
            case .update(let vo, deletions: _, insertions: _, modifications: _):
                subject.send(Array(vo))
            default:
                debugPrint("Hello")
            }
      
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    func saveBookCollectionByListID(id: Int,data: [Book]) {
        guard let bookCategory = realmInstance.object(ofType: ListVO.self, forPrimaryKey: id) else { return }
        let bookArray: [BookVO] = data.map { book in
            return book.convertToBookVO()
        }
        let bookList = List<BookVO>()
        bookList.append(objectsIn: bookArray)
    
        do {
            try realmInstance.write {
                realmInstance.add(bookArray, update: .modified)
                bookCategory.books = bookList
                
                
            }
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func getBookCollectionByListID(id: Int) -> AnyPublisher<[BookVO], Never>  {
        let bookCategory = realmInstance.objects(ListVO.self).filter("listID=\(id)")
        let books: [BookVO] = Array(bookCategory.first!.books )
        let subject = CurrentValueSubject<[BookVO], Never>([])
        subject.send(books)
        
         notificationToken3 = bookCategory.observe { [weak self] changes in
             guard let _ = self else { return }
             switch changes {
             case .update(let vo, deletions: _, insertions: _, modifications: _):
                 subject.send(Array(vo.first!.books))
             default:
                 debugPrint("Hello")
             }

         }
        
        return subject.eraseToAnyPublisher()
    }
    
    func getWishList(sort by: String)  -> AnyPublisher<[WishlistVO], Never>  {
        let wishList = by == "recentlyDate" ? realmInstance.objects(WishlistVO.self).sorted(byKeyPath: by, ascending: false) : realmInstance.objects(WishlistVO.self).sorted(byKeyPath: by, ascending: true)
        
        let subject = CurrentValueSubject<[WishlistVO], Never>([])
        subject.send(Array(wishList))
        
       
        notificationToken4 = wishList.observe { [weak self] changes in
            guard let _ = self else { return }
            switch changes {
            case .update(let vo, deletions: _, insertions: _, modifications: _):
                subject.send(Array(vo))
            default:
                debugPrint("\(#function)")
            }
      
        }
        
        return subject.eraseToAnyPublisher()
        
    }
    
    func isInWishlistByID(with bookVO: BookVO) -> Bool {
        let wishlist = realmInstance.object(ofType: WishlistVO.self, forPrimaryKey: bookVO.primaryIsbn13)
        guard let _ = wishlist else { return false }
        return true
    }
    
    func addToWishlist(with bookVO : BookVO) -> Bool {
        let wishlist = WishlistVO()
        wishlist.primaryIsbn13 = bookVO.primaryIsbn13
        wishlist.book = bookVO
        wishlist.recentlyDate = Date()
        wishlist.title = bookVO.title
        wishlist.author = bookVO.author
        do {
            try realmInstance.write {
                realmInstance.add(wishlist, update: .modified)
            }
        }catch {
            debugPrint(error.localizedDescription)
            return false
        }
        
        return true
        
    }
    
    func removeFromWishlist(with bookVO: BookVO) -> Bool {
        let wishlist = realmInstance.object(ofType: WishlistVO.self, forPrimaryKey: bookVO.primaryIsbn13)
        guard let wishlistVO = wishlist else {
            return false
        }
        
        do {
            try realmInstance.write({
                realmInstance.delete(wishlistVO)
            })
        }catch {
            debugPrint(error.localizedDescription)
            return false
        }
        
        return true
    }
    
}
