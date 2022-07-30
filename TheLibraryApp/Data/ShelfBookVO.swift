//
//  ShelfBookVO.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 21/07/2565 BE.
//

import Foundation
import RealmSwift

class ShelfBookVO: Object {
    @Persisted(primaryKey: true)
    var id: String?
    
    @Persisted
    var recentlyDate: Date
    
    @Persisted
    var shelfID: String
    
    @Persisted
    var title: String?
    
    @Persisted
    var author: String?
    
    @Persisted
    var book: BookVO?
}
