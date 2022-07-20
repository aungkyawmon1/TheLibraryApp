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
        //self.present(vc, animated: true)
    }
    
    
    func navigateToDetail(book: BookVO) {
        let vc = BookDetailViewController()
        vc.selectedBook = book
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToShelfUpdate() {
        let vc = ShelfUpdateViewController()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
        //self.tabBarController?.present(vc, animated: true)
    }
    
    func navigateToRatingsAndReviews() {
        let vc = RatingsAndReviewsViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToCreateShelf() {
        let vc = CreateShelfViewController()
//        vc.modalPresentationStyle = .fullScreen
//        vc.modalTransitionStyle = .flipHorizontal
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToShelfDetail(){
        let vc = ShelfDetailViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToAddShelf() {
        let vc = AddToShelfViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
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
