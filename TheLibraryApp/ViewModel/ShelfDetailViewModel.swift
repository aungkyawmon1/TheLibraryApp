//
//  ShelfDetailViewModel.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 22/07/2565 BE.
//

import Foundation
import Combine

enum ShelfDetailState {
    case success
    case failure(message: String)
    case shelfTitle(title: String)
}

class ShelfDetailViewModel {
    
    private var shelfModel : ShelfModelProtocol
    private var shelfVO : ShelfVO
    private var bag = Set<AnyCancellable>()
    var viewState: PassthroughSubject<ShelfDetailState, Never> = .init()
    private var shelfBooks = [ShelfBookVO]()
    
    init(shelfModel: ShelfModel, shelfVO : ShelfVO) {
        self.shelfModel = shelfModel
        self.shelfVO = shelfVO
    }
    
    var bookCount : String {
        get {
            return shelfVO.book.count > 0 ? "\(shelfVO.book.count) Books" : "0 Book"
        }
    }
    
    var shelf: ShelfVO {
        get {
            return shelfVO
        }
    }
    
    func getShelf() {
        shelfModel.getShelfByID(id: shelfVO.id)
            .sink { [weak self] data in
                guard let self = self else { return }
                self.viewState.send(.shelfTitle(title: data.shelfTitle))
            }.store(in: &bag)
    }
    
    func getShelfBooks(sort by: String ) {
        shelfModel.getShelfBookByShelf(shelfID: shelfVO.id,sort: by)
            .sink { [weak self] data in
                guard let self = self else {return}
                self.shelfBooks = data
                self.viewState.send(.success)
            }.store(in: &bag)
    }
    
    func getShelfBooksCount() -> Int {
        return shelfBooks.count
    }
    
    func getShelfBook(at index: Int) -> ShelfBookVO {
        return shelfBooks[index]
    }
    
    func getBook(at index: Int) -> BookVO {
        return shelfBooks[index].book ?? BookVO()
    }
}
