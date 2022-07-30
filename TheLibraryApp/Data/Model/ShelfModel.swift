//
//  ShelfModel.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 21/07/2565 BE.
//

import Foundation
import Combine

protocol ShelfModelProtocol {
    func saveShelf(shelf: ShelfVO) -> Bool
    func getShelf() -> AnyPublisher<[ShelfVO], Never>
    
    func saveShelfBook(shelf: ShelfVO, bookVO: BookVO) -> Bool
    func getShelfBookByShelf(shelfID: String, sort by: String) -> AnyPublisher<[ShelfBookVO], Never>
    func getShelfByID(id: String) -> AnyPublisher<ShelfVO, Never >
    
    func isInShelfBook(id: String) -> Bool
    func deleteShelf(shelfVO : ShelfVO) -> Bool
    func editShelfTitle(shelfVO: ShelfVO, title: String) -> Bool
}

class ShelfModel: BaseModel, ShelfModelProtocol {

    
    static let shared = ShelfModel()
    private let shelfRepository: ShelfProtocol = ShelfRepository.shared
    private override init() { }
    
    func saveShelf(shelf: ShelfVO) -> Bool {
        return shelfRepository.saveShelf(shelf: shelf)
    }
    
    func getShelf() -> AnyPublisher<[ShelfVO], Never> {
        return shelfRepository.getShelf()
    }
    
    func saveShelfBook(shelf: ShelfVO, bookVO: BookVO) -> Bool {
        return shelfRepository.saveShelfBook(shelf: shelf, bookVO: bookVO)
    }
    
    func getShelfBookByShelf(shelfID: String, sort by: String) -> AnyPublisher<[ShelfBookVO], Never> {
        return shelfRepository.getShelfBookByShelf(shelfID: shelfID,sort: by)
    }
    
    func getShelfByID(id: String) -> AnyPublisher<ShelfVO, Never > {
        return shelfRepository.getShelfByID(id: id)
    }
    
    func isInShelfBook(id: String) -> Bool {
        return shelfRepository.isInShelfBook(id: id)
    }
    
    func deleteShelf(shelfVO : ShelfVO) -> Bool {
        return shelfRepository.deleteShelf(shelfVO: shelfVO)
    }
    func editShelfTitle(shelfVO: ShelfVO, title: String) -> Bool {
        return shelfRepository.editShelfTitle(shelfVO: shelfVO, title: title)
    }
}
