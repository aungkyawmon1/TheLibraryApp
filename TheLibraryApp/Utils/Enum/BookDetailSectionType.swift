//
//  BookDetailSectionType.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 06/07/2022.
//

import Foundation

enum BookDetailSectionType {
    case bookInfo(image: String, title: String, author: String)
    case bookActionItem
    case aboutBook(description: String)
    case ratingAndReviews
    case comments(comment: [Comment])
    case published
    case rating
}
struct Comment {
    let comment: String
}
