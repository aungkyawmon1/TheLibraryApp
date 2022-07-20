//
//  RecentDetailVO.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 14/07/2565 BE.
//

import Foundation
import RealmSwift

class RecentDetailVO: Object {
    @Persisted(primaryKey: true)
    var primaryIsbn13: String?
    
    @Persisted
    var recentlyDate: Date
    
    @Persisted
    var book: BookVO?
}
