//
//  YourBooksProtocol.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 09/07/2565 BE.
//

import Foundation

protocol YourBooksProtocol: AnyObject {
    func removeDownload(id: String)
    func addToShelves(id: String)
    func readAboutThisBook(id: String)
}
