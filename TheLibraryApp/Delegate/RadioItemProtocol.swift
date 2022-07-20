//
//  RadioItemProtocol.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 03/07/2022.
//

import Foundation

protocol RadioItemProtocol: AnyObject {
    func onTapRadioItem(index: Layout)
    func onTapRadioForSort(index: SortBy)
}
