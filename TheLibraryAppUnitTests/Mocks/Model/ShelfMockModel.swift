//
//  ShelfMockModel.swift
//  TheLibraryAppUnitTests
//
//  Created by MacBook Pro on 28/07/2565 BE.
//

import Foundation
@testable import TheLibraryApp
import Combine

class ShelfMockModel: ShelfModelProtocol {
    let shelfRepository = ShelfRepository.shared
    
    func saveShelf(shelf: ShelfVO) -> Bool {
        shelfRepository.saveShelf(shelf: shelf)
    }
    
    func getShelf() -> AnyPublisher<[ShelfVO], Never> {
        shelfRepository.getShelf()
    }
    
    func saveShelfBook(shelf: ShelfVO, bookVO: BookVO) -> Bool {
        false
    }
    
    func getShelfBookByShelf(shelfID: String, sort by: String) -> AnyPublisher<[ShelfBookVO], Never> {
        Empty(completeImmediately: true).eraseToAnyPublisher()
    }
    
    func getShelfByID(id: String) -> AnyPublisher<ShelfVO, Never> {
        Empty(completeImmediately: true).eraseToAnyPublisher()
    }
    
    func isInShelfBook(id: String) -> Bool {
        false
    }
    
    func deleteShelf(shelfVO: ShelfVO) -> Bool {
        false
    }
    
    func editShelfTitle(shelfVO: ShelfVO, title: String) -> Bool {
        false
    }
    
}
