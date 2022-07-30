//
//  ShelfVO.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 20/07/2565 BE.
//

import Foundation
import RealmSwift

class ShelfVO: Object {
    @Persisted(primaryKey: true)
    var id: String
    
    @Persisted
    var recentlyDate: Date
    
    @Persisted
    var shelfTitle: String
    
    @Persisted
    var book: List<ShelfBookVO>
    
    @Persisted
    var image: String?
}
