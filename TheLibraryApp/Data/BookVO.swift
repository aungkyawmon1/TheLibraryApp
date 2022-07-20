//
//  BookVO.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 11/07/2565 BE.
//

import Foundation
import RealmSwift

// MARK: - Book
class BookVO: Object {
    
    @Persisted(primaryKey: true)
    var primaryIsbn13: String?
    
    @Persisted
    var ageGroup: String?
    
    @Persisted
    var amazonProductURL: String?
    
    @Persisted
    var articleChapterLink: String?

    @Persisted
    var author: String?
    
    @Persisted
    var bookImage: String?
    
    @Persisted
    var bookImageWidth: Int?

    @Persisted
    var bookImageHeight: Int?
    
    @Persisted
    var bookReviewLink: String?
    
    @Persisted
    var contributor: String?
    
    @Persisted
    var contributorNote: String?
    
    @Persisted
    var createdDate: String?
    
    @Persisted
    var bookDescription: String?
    
    @Persisted
    var firstChapterLink: String?

    @Persisted
    var price: String?
    
    @Persisted
    var primaryIsbn10: String?
    
    @Persisted
    var bookURI: String?

    @Persisted
    var publisher: String?
    
    @Persisted
    var rank: Int?

    @Persisted
    var rankLastWeek: Int?
    
    @Persisted
    var sundayReviewLink: String?
    
    @Persisted
    var title: String?

    @Persisted
    var updatedDate: String?
    
    @Persisted
    var weeksOnList: Int?
    
    @Persisted
    var buyLinks: List<BuyLinkVO>
    
    @Persisted
    var list: List<ListVO>
}
