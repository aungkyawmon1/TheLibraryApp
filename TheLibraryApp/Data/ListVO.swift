//
//  ListVO.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 11/07/2565 BE.
//

import Foundation
import RealmSwift

// MARK: - List
class ListVO: Object {
    
    @Persisted(primaryKey: true)
    var listID: Int?
    
    @Persisted
    var listName: String?
    
    @Persisted
    var listNameEncoded: String?

    @Persisted
    var displayName: String?
    
    @Persisted
    var updated: String?
    
    @Persisted
    var listImage: String?
    
    @Persisted
    var listImageWidth: String?
    
    @Persisted
    var listImageHeight: String?
    
    @Persisted
    var books: List<BookVO>
    
}
