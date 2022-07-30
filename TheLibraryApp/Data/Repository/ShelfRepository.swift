//
//  ShelfRepository.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 21/07/2565 BE.
//

import Foundation
import Combine
import RealmSwift

protocol ShelfProtocol {
    func saveShelf(shelf: ShelfVO) -> Bool
    func getShelf() -> AnyPublisher<[ShelfVO], Never>
    
    func saveShelfBook(shelf: ShelfVO, bookVO: BookVO) -> Bool
    func getShelfBookByShelf(shelfID: String, sort by: String) -> AnyPublisher<[ShelfBookVO], Never>
    func getShelfByID(id: String) -> AnyPublisher<ShelfVO, Never >
    
    func isInShelfBook(id: String) -> Bool
    func deleteShelf(shelfVO : ShelfVO) -> Bool
    func editShelfTitle(shelfVO: ShelfVO, title: String) -> Bool
}

class ShelfRepository: BaseRepository, ShelfProtocol {
    static let shared = ShelfRepository()
    var notificationToken: NotificationToken?
    var notificationToken1: NotificationToken?
    var notificationToken2: NotificationToken?
    private override init() {}
    
    func saveShelf(shelf: ShelfVO) -> Bool {
        do {
            try realmInstance.write({
                realmInstance.add(shelf, update: .modified)
            })
        } catch {
            debugPrint(error.localizedDescription)
        }
        
        return true
    }
    
    func getShelf() -> AnyPublisher<[ShelfVO], Never> {
        let shelves = realmInstance.objects(ShelfVO.self)
        
        let subject = CurrentValueSubject<[ShelfVO], Never>([])
        subject.send(Array(shelves))
        
        notificationToken = shelves.observe { [weak self] changes in
            guard let _ = self else { return }
            switch changes {
            case .update(let vo, deletions: _, insertions: _, modifications: _):
                debugPrint("getShelf Notified")
                subject.send(Array(vo))
            
               // self?.notificationToken?.invalidate()
            default:
                debugPrint("getShelf")
            }
      
        }
        
        return subject.eraseToAnyPublisher()
        
    }
    
    func getShelfByID(id: String) -> AnyPublisher<ShelfVO, Never > {
        let shelf = realmInstance.objects(ShelfVO.self).filter("id = %@", id)
        
        let subject = CurrentValueSubject<ShelfVO, Never>(ShelfVO())
        if let shelf = shelf.first {
            subject.send(shelf)
        }
     
        
        notificationToken2 = shelf.observe { [weak self] changes in
            guard let _ = self else { return }
            switch changes {
            case .update(let vo, deletions: _, insertions: _, modifications: _):
                if let shelf = vo.first {
                    subject.send(shelf)
                    self?.notificationToken2?.invalidate()
                }
            default:
                debugPrint("Hello")
            }
      
        }
        
        return subject.eraseToAnyPublisher()
        
    }
    
    func saveShelfBook(shelf: ShelfVO, bookVO: BookVO) -> Bool{
        let shelfBook = ShelfBookVO()
        shelfBook.id = "\(bookVO.primaryIsbn13 ?? "")\(shelf.shelfTitle)"
        shelfBook.title = bookVO.title
        shelfBook.author = bookVO.author
        shelfBook.recentlyDate = Date()
        shelfBook.shelfID = shelf.id
        shelfBook.book = bookVO
        do {
            try realmInstance.write({
                realmInstance.add(shelfBook, update: .modified)
                shelf.book.append(shelfBook)
                shelf.image = bookVO.bookImage
            })
        } catch {
            debugPrint(error.localizedDescription)
        }
        
        return true
    }
    
    func getShelfBookByShelf(shelfID: String, sort by: String) -> AnyPublisher<[ShelfBookVO], Never> {
        let shelfBooks = by == "recentlyDate" ? realmInstance.objects(ShelfBookVO.self).filter("shelfID = %@", shelfID ).sorted(byKeyPath: by, ascending: false) :  realmInstance.objects(ShelfBookVO.self).filter("shelfID = %@", shelfID).sorted(byKeyPath: by, ascending: true)
        
        let subject = CurrentValueSubject<[ShelfBookVO], Never>([])
        subject.send(Array(shelfBooks))
        
        notificationToken1 = shelfBooks.observe { [weak self] changes in
            guard let _ = self else { return }
            switch changes {
            case .update(let vo, deletions: _, insertions: _, modifications: _):
                subject.send(Array(vo))
                self?.notificationToken1?.invalidate()
            default:
                debugPrint("Hello")
            }
      
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    func isInShelfBook(id: String) -> Bool {
        guard let _ = realmInstance.object(ofType: ShelfBookVO.self, forPrimaryKey: id) else {
            return false
        }
        return true
    }
    
    func deleteShelf(shelfVO : ShelfVO) -> Bool {
        let shelfBooks = realmInstance.objects(ShelfBookVO.self).filter("shelfID = %@", shelfVO.id)
        
        do {
            try realmInstance.write({
                realmInstance.delete(shelfBooks)
                realmInstance.delete(shelfVO)
            })
        }catch {
            debugPrint(error.localizedDescription)
            return false
        }
        
        return true
    }
    
    func editShelfTitle(shelfVO: ShelfVO, title: String) -> Bool {
        do {
            try realmInstance.write({
                shelfVO.shelfTitle = title
            })
        } catch {
            debugPrint(error.localizedDescription)
            return false
        }
        
        return true
    }
}
