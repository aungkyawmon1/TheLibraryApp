//
//  YourBooksProtocol.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 09/07/2565 BE.
//

import Foundation

protocol YourBooksProtocol: AnyObject {
    func removeDownload(book: BookVO)
    func addToShelves(book: BookVO)
    func readAboutThisBook(book: BookVO)
}
