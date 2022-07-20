//
//  WishlistVO.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 20/07/2565 BE.
//

import Foundation
import RealmSwift

class WishlistVO: Object {
    @Persisted(primaryKey: true)
    var primaryIsbn13: String?
    
    @Persisted
    var recentlyDate: Date
    
    @Persisted
    var title: String?
    
    @Persisted
    var author: String?
    
    @Persisted
    var book: BookVO?
}
