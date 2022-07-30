//
//  BookListByListNameResponse.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 17/07/2565 BE.
//

import Foundation

// MARK: -
class BookListByListNameResponse: Codable {
    let status, copyright: String?
    let numResults: Int?
    let results: ResultsByListName?

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
    
    init(status: String?, copyright: String?, numResults: Int?, results: ResultsByListName?) {
        self.status = status
        self.copyright = copyright
        self.numResults = numResults
        self.results = results
    }
    
}

// MARK: - ResultsByListName
class ResultsByListName: Codable {
    
    let listName, listNameEncoded, bestsellersDate, publishedDate: String?
    let publishedDateDescription, nextPublishedDate, previousPublishedDate, displayName: String?
    let normalListEndsAt: Int?
    let updated: String?
    let books: [Book]?

    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case listNameEncoded = "list_name_encoded"
        case bestsellersDate = "bestsellers_date"
        case publishedDate = "published_date"
        case publishedDateDescription = "published_date_description"
        case nextPublishedDate = "next_published_date"
        case previousPublishedDate = "previous_published_date"
        case displayName = "display_name"
        case normalListEndsAt = "normal_list_ends_at"
        case updated, books
    }
    
    init(listName: String?, listNameEncoded: String?, bestsellersDate: String?, publishedDate: String?, publishedDateDescription: String?, nextPublishedDate: String?, previousPublishedDate: String?, displayName: String?, normalListEndsAt: Int?, updated: String?, books: [Book]?) {
           self.listName = listName
           self.listNameEncoded = listNameEncoded
           self.bestsellersDate = bestsellersDate
           self.publishedDate = publishedDate
           self.publishedDateDescription = publishedDateDescription
           self.nextPublishedDate = nextPublishedDate
           self.previousPublishedDate = previousPublishedDate
           self.displayName = displayName
           self.normalListEndsAt = normalListEndsAt
           self.updated = updated
           self.books = books
       }
}
