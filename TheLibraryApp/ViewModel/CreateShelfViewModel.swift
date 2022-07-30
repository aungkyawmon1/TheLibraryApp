//
//  CreateShelfViewModel.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 21/07/2565 BE.
//

import Foundation
import Combine

enum CreateShelfState {
    case success
    case validate(message: String)
    case invalidate(message: String)
}

class CreateShelfViewModel {
    private var bag = Set<AnyCancellable>()
    var viewState: PassthroughSubject<CreateShelfState, Never> = .init()
    private var shelfModel : ShelfModelProtocol
    private var shelfVO : ShelfVO
    private var isRename : Bool
    
    init(shelfModel: ShelfModel, shelfVO: ShelfVO, isRename: Bool){
        self.shelfModel = shelfModel
        self.shelfVO = shelfVO
        self.isRename = isRename
    }
    
    var shelfTitle : String {
        get {
            return shelfVO.shelfTitle
        }
    }
    
    func saveShelf(title: String ){
        let shelf = ShelfVO()
        shelf.id = UUID().uuidString
        shelf.shelfTitle = title
        shelf.recentlyDate = Date()
        if shelfModel.saveShelf(shelf: shelf) {
            viewState.send(.success)
        }
    }
    
    func editShelfTitle(title: String) {
        if shelfModel.editShelfTitle(shelfVO: shelfVO, title: title) {
            viewState.send(.success)
        }
    }
    
    func isRenameState() -> Bool {
        return isRename
    }
    
    
    func validateTitle(title: String){
        
        if title.count > 0 && title.count <= 50 {
            viewState.send(.validate(message:  "\(title.count) / 50"))
        } else {
            viewState.send(.invalidate(message: "Title must be between 0 and 50"))
        }
        
    }
    
    
}
