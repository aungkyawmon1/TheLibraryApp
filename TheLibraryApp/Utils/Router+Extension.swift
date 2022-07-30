//
//  Router+Extension.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 03/07/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func navigateToMoreAction(bookVO: BookVO) {
        let vc = MoreActionViewController()
        vc.viewModel = MoreActionViewModel(bookModel: BookModel.shared, bookVO: bookVO)
        vc.modalPresentationStyle = .overCurrentContext
        self.tabBarController?.present(vc, animated: true)
    }
    
    
    func navigateToDetail(book: BookVO) {
        let vc = BookDetailViewController()
        vc.viewModel = BookDetailViewModel(bookModel: BookModel.shared, bookVO: book)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
    func navigateToRatingsAndReviews() {
        let vc = RatingsAndReviewsViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToCreateShelf(shelfVO: ShelfVO = ShelfVO(), isReanme : Bool = false) {
        let vc = CreateShelfViewController()
        vc.viewModel = CreateShelfViewModel(shelfModel: ShelfModel.shared, shelfVO: shelfVO, isRename: isReanme)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToShelfDetail(shelfVO: ShelfVO){
        let vc = ShelfDetailViewController()
        vc.viewModel = ShelfDetailViewModel(shelfModel: ShelfModel.shared, shelfVO: shelfVO)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToAddShelf(book: BookVO = BookVO()) {
        let vc = AddToShelfViewController()
        vc.viewModel = AddToShelfViewModel(shelfModel: ShelfModel.shared, book: book)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToSearch() {
        let vc = SearchViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToShowMore(_ id: Int,_ listNameEncoded: String) {
        let vc = CategoryViewMoreViewController()
        vc.viewModel = ShowMoreViewModel(bookModel: BookModel.shared, listID: id, listNameEncoded: listNameEncoded)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
