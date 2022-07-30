//
//  HomeViewModel.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 17/07/2565 BE.
//

import Foundation
import Combine
enum HomeViewState {
    case success(type: HomeViewControllerSectionType)
    case failure(message: String)
}


class HomeViewModel {
    
    private var bookModel: BookModelProtocol
    var bag = Set<AnyCancellable>()
    var viewState: PassthroughSubject<HomeViewState, Never> = .init()
    var someValue: CurrentValueSubject<HomeViewState, Never> = CurrentValueSubject<HomeViewState, Never>(.failure(message: ""))
    private var items: [HomeViewControllerSectionType] = [
            .RecentlyOpenedItems(items: [RecentDetailVO]()),
            .CategorySelection,
            .ItemList(items: [ListVO]())
    ]
    
    init(bookModel: BookModelProtocol) {
        self.bookModel = bookModel
    }
    
    func fetchAllData() {
        fetchRecentDetailedBook()
        fetchBookList()
    }
    
    func getSectionCount() -> Int {
        return items.count
    }
    
    func getItemSection(_ section: Int) -> HomeViewControllerSectionType {
        return items[section]
    }
    
    func getNubmerOfRowInSection(sectionType: HomeViewControllerSectionType) -> Int {
        switch sectionType {
        case .RecentlyOpenedItems(let items):
            return items.count > 0 ? 1 : 0
        case .CategorySelection:
            return 1
        case .ItemList(let items):
            return items.count
        }
    }
    
    func fetchRecentDetailedBook() {
        
        bookModel.getRecentlyDetailedBooks()
            .sink(receiveCompletion: { error in
                self.viewState.send(.failure(message: "\(error)"))
            }, receiveValue: { list in
                self.items[0] = .RecentlyOpenedItems(items: list)
                self.viewState.send(.success(type: .RecentlyOpenedItems(items: list)))
             //   self.someValue.send(.success(type: .RecentlyOpenedItems(items: list)))
                debugPrint("test in homwviewmodel")
            }).store(in: &bag)
    }
    
    func fetchBookList() {
        bookModel.getBookListOverview()
            .sink { listVO in
                self.items[2] = .ItemList(items: listVO)
                self.viewState.send(.success(type: .ItemList(items: listVO)))
               // self.someValue.send(.success(type: .ItemList(items: listVO)))
            }.store(in: &bag)
    }
}
