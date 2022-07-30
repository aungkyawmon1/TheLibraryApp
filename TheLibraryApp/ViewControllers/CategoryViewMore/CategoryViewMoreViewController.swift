//
//  CategoryViewMoreViewController.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 09/07/2565 BE.
//

import UIKit
import Combine

class CategoryViewMoreViewController: UIViewController {

    @IBOutlet weak var bookCollectionView : UICollectionView!
    
    var viewModel = ShowMoreViewModel(bookModel: BookModel.shared, listID: 0, listNameEncoded: "")
    var bag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        viewModel.viewState
            .sink { state in
            switch state {
            case .success:
                self.bookCollectionView.reloadData()
            case .failure(let message):
                debugPrint(message)
            }
        }.store(in: &bag)
        viewModel.fetchData()
    }
    
    private func registerCells() {
        bookCollectionView.dataSource = self
        bookCollectionView.delegate = self
        bookCollectionView.registerForCell(identifier: BookListCollectionViewCell.identifier)
    }
    
    
    func navigateToMoreActionDelegate(bookVO: BookVO) {
        let vc = MoreActionViewController()
        vc.delegate = self
        vc.viewModel = MoreActionViewModel(bookModel: BookModel.shared, bookVO: bookVO)
        vc.modalPresentationStyle = .overCurrentContext
        self.tabBarController?.present(vc, animated: true)
    }

}

extension CategoryViewMoreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getBookCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListCollectionViewCell.identifier, for: indexPath) as? BookListCollectionViewCell else { return UICollectionViewCell() }
        cell.delegate = self
        cell.book = viewModel.getBook(with: indexPath.row)
        return cell
    }
    
    
}

extension CategoryViewMoreViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigateToDetail(book: viewModel.getBook(with: indexPath.row))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: (width-60)/2 , height: 300)
    }
}


extension CategoryViewMoreViewController: ViewMoreProtocol {
    func clickViewMore(bookVO: BookVO) {
        navigateToMoreActionDelegate(bookVO: bookVO)
    }
}

extension CategoryViewMoreViewController: YourBooksProtocol {
    func removeDownload(book: BookVO) {
        
    }
    
    func addToShelves(book: BookVO) {
        navigateToAddShelf()
    }
    
    func readAboutThisBook(book: BookVO) {
        navigateToDetail(book: book)
    }
    
}
