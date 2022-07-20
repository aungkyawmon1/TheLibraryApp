//
//  HomeViewControllerSectionType.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 17/07/2565 BE.
//

import Foundation

enum HomeViewControllerSectionType {
    case RecentlyOpenedItems(items: [RecentDetailVO])
    case CategorySelection
    case ItemList(items: [ListVO])
}
