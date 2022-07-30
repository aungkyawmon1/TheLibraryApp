//
//  ShelfUpdateViewModel.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 23/07/2565 BE.
//

import Foundation
import Combine

enum ShelfUpdateState {
    case deletion
    case rename
    case failure(message: String)
}

class ShelfUpdateViewModel {
    private var shelfModel : ShelfModelProtocol
    private var shelfVO : ShelfVO
    private var bag = Set<AnyCancellable>()
    var viewState: PassthroughSubject<ShelfUpdateState, Never> = .init()
    
    init(shelfModel: ShelfModel, shelfVO : ShelfVO) {
        self.shelfModel = shelfModel
        self.shelfVO = shelfVO
    }
    
    var shelfTitle: String? {
        get {
            return shelfVO.shelfTitle
        }
    }
    
    func getShelfVO() -> ShelfVO {
        return shelfVO
    }
    
    func deleteShelf() -> Bool {
        return shelfModel.deleteShelf(shelfVO: shelfVO)
    }
}
