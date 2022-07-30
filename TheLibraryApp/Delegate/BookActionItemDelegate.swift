//
//  BookActionItemDelegate.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 21/07/2565 BE.
//

import Foundation

protocol BookActionItemDelegate: AnyObject {
    func addToWishlist()
    func deleteFromWishlist()
}
