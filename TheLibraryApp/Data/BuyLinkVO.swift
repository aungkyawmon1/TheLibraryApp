//
//  BuyLinkVO.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 11/07/2565 BE.
//

import Foundation
import RealmSwift

// MARK: - BuyLink
class BuyLinkVO: Object {
    
    @Persisted(primaryKey: true)
    var id: String?
    
    @Persisted
    var name: String?
    
    @Persisted
    var url: String?
}
