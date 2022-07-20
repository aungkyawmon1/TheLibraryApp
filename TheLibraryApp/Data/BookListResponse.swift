//
//  BookListResponse.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 04/07/2022.
//

import Foundation

// MARK: - BoolListResponse
class BookListResponse: Codable {
    let status, copyright: String?
    let numResults: Int?
    let results: BookResults?

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }

    init(status: String?, copyright: String?, numResults: Int?, results: BookResults?) {
        self.status = status
        self.copyright = copyright
        self.numResults = numResults
        self.results = results
    }
}


// MARK: - BookResults
class BookResults: Codable {
    let bestsellersDate, publishedDate, publishedDateDescription, previousPublishedDate: String?
    let nextPublishedDate: String?
    let lists: [BookList]?

    enum CodingKeys: String, CodingKey {
        case bestsellersDate = "bestsellers_date"
        case publishedDate = "published_date"
        case publishedDateDescription = "published_date_description"
        case previousPublishedDate = "previous_published_date"
        case nextPublishedDate = "next_published_date"
        case lists
    }

    init(bestsellersDate: String?, publishedDate: String?, publishedDateDescription: String?, previousPublishedDate: String?, nextPublishedDate: String?, lists: [BookList]?) {
        self.bestsellersDate = bestsellersDate
        self.publishedDate = publishedDate
        self.publishedDateDescription = publishedDateDescription
        self.previousPublishedDate = previousPublishedDate
        self.nextPublishedDate = nextPublishedDate
        self.lists = lists
    }
    
}

// MARK: - List
class BookList: Codable {
    let listID: Int?
    let listName, listNameEncoded, displayName: String?
    let updated: String?
    let listImage, listImageWidth, listImageHeight: String?
    let books: [Book]?

    enum CodingKeys: String, CodingKey {
        case listID = "list_id"
        case listName = "list_name"
        case listNameEncoded = "list_name_encoded"
        case displayName = "display_name"
        case updated
        case listImage = "list_image"
        case listImageWidth = "list_image_width"
        case listImageHeight = "list_image_height"
        case books
    }
    
    func convertToBookVO() -> ListVO {
        let listVO = ListVO()
        listVO.listID = listID
        listVO.listName = listName
        listVO.listNameEncoded = listNameEncoded
        listVO.displayName = displayName
        listVO.updated = updated
        listVO.listImage = listImage
        listVO.listImageWidth = listImageWidth
        listVO.listImageHeight = listImageHeight
        return listVO
    }
}

// MARK: - Book
class Book: Codable {
    let ageGroup: String?
    let amazonProductURL: String?
    let articleChapterLink, author: String?
    let bookImage: String?
    let bookImageWidth, bookImageHeight: Int?
    let bookReviewLink: String?
    let contributor: String?
    let contributorNote: String?
    let createdDate, bookDescription, firstChapterLink, price: String?
    let primaryIsbn10, primaryIsbn13, bookURI, publisher: String?
    let rank, rankLastWeek: Int?
    let sundayReviewLink: String?
    let title, updatedDate: String?
    let weeksOnList: Int?
    let buyLinks: [BuyLink]?

    enum CodingKeys: String, CodingKey {
        case ageGroup = "age_group"
        case amazonProductURL = "amazon_product_url"
        case articleChapterLink = "article_chapter_link"
        case author
        case bookImage = "book_image"
        case bookImageWidth = "book_image_width"
        case bookImageHeight = "book_image_height"
        case bookReviewLink = "book_review_link"
        case contributor
        case contributorNote = "contributor_note"
        case createdDate = "created_date"
        case bookDescription = "description"
        case firstChapterLink = "first_chapter_link"
        case price
        case primaryIsbn10 = "primary_isbn10"
        case primaryIsbn13 = "primary_isbn13"
        case bookURI = "book_uri"
        case publisher, rank
        case rankLastWeek = "rank_last_week"
        case sundayReviewLink = "sunday_review_link"
        case title
        case updatedDate = "updated_date"
        case weeksOnList = "weeks_on_list"
        case buyLinks = "buy_links"
    }
    
    func convertToBookVO() -> BookVO {
        let bookVO = BookVO()
        bookVO.ageGroup = ageGroup
        bookVO.amazonProductURL = amazonProductURL
        bookVO.articleChapterLink = articleChapterLink
        bookVO.author = author
        bookVO.bookImage = bookImage
        bookVO.bookImageWidth = bookImageWidth
        bookVO.bookImageHeight = bookImageHeight
        bookVO.bookReviewLink = bookReviewLink
        bookVO.contributor = contributor
        bookVO.contributorNote = contributorNote
        bookVO.createdDate = createdDate
        bookVO.bookDescription = bookDescription
        bookVO.firstChapterLink = firstChapterLink
        bookVO.price = price
        bookVO.primaryIsbn10 = primaryIsbn10
        bookVO.primaryIsbn13 = primaryIsbn13
        bookVO.bookURI = bookURI
        bookVO.publisher = publisher
        bookVO.sundayReviewLink = sundayReviewLink
        bookVO.title = title
        bookVO.updatedDate = updatedDate
        bookVO.weeksOnList = weeksOnList
        return bookVO
    }
}

// MARK: - BuyLink
class BuyLink: Codable {
    let name: String?
    let url: String?
    
    func convertToBuyLink() -> BuyLinkVO {
        let buyLinkVO = BuyLinkVO()
        buyLinkVO.name = name
        buyLinkVO.url = url
        return buyLinkVO
    }
}
