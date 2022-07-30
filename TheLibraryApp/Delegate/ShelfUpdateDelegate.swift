//
//  ShelfDeletionDelegate.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 23/07/2565 BE.
//

import Foundation

protocol ShelfUpdateDelegate : AnyObject {
    func isDeleted()
    func rename(shelfVO: ShelfVO, isReanme: Bool)
}
