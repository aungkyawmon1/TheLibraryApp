//
//  ShelfDetailViewController.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 08/07/2022.
//

import UIKit
import Combine

class ShelfDetailViewController: UIViewController {

    @IBOutlet weak var bookCollectionView : UICollectionView!
    @IBOutlet weak var sortByLbl : UILabel!
    @IBOutlet weak var sortAndGridView : UIView!
    
    @IBOutlet weak var lblBookCount: UILabel!
    @IBOutlet weak var lblShelfTitle: UILabel!
    private var bag = Set<AnyCancellable>()
    private var gridState: Layout = .list
    private var sortBy: SortBy = .recent
    
    var viewModel = ShelfDetailViewModel(shelfModel: ShelfModel.shared, shelfVO: ShelfVO() )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav()
        registerCells()
        
        viewModel.viewState
            .sink { state in
                switch state {
                case .success:
                    self.bookCollectionView.reloadData()
                case .failure(message: let message):
                    debugPrint(message)
                case .shelfTitle(title: let title):
                    self.lblShelfTitle.text = title
                }
            }.store(in: &bag)
        
        viewModel.getShelfBooks(sort: "recentlyDate")
        viewModel.getShelf()
    }

    
    private func setUpNav() {
        navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(onTapViewMore))
        
        lblBookCount.text = viewModel.bookCount
        
      
    }
    
    private func registerCells() {
        bookCollectionView.dataSource = self
        bookCollectionView.delegate = self
        bookCollectionView.registerForCell(identifier: BookListCollectionViewCell.identifier)
        bookCollectionView.registerForCell(identifier: BookListAsListCollectionViewCell.identifier)
        bookCollectionView.registerForCell(identifier: ShelfCollectionViewCell.identifier)
    }
    
    func navigateToShelfUpdate(shelfVO: ShelfVO) {
        let vc = ShelfUpdateViewController()
        vc.viewModel = ShelfUpdateViewModel(shelfModel: ShelfModel.shared, shelfVO: shelfVO)
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        present(vc, animated: true)
        //self.tabBarController?.present(vc, animated: true)
    }
    
    @objc private func onTapViewMore() {
        navigateToShelfUpdate(shelfVO: viewModel.shelf)
    }
    
    @IBAction func btnSortByClicked(_ sender: UIButton) {
       navigateToSortBy()
    }
    
    @IBAction func btnGridClicked(_ sender: UIButton) {
        navigateToViewAsViewController()
    }
    
    func navigateToViewAsViewController(index: Layout = .list) {
        let vc = ViewAsViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        vc.selectedGrid = index
        vc.hidesBottomBarWhenPushed = true
        self.tabBarController?.present(vc, animated: true)
    }
    
    func navigateToSortBy(index: SortBy = .recent) {
        let vc = SortByViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        vc.selectedGrid = index
        vc.hidesBottomBarWhenPushed = true
        self.tabBarController?.present(vc, animated: true)
    }
    
    private func navigateToMoreActionDelegate(bookVO: BookVO) {
        let vc = MoreActionViewController()
        vc.delegate = self
        vc.viewModel = MoreActionViewModel(bookModel: BookModel.shared, bookVO: bookVO)
        vc.modalPresentationStyle = .overCurrentContext
        self.tabBarController?.present(vc, animated: true)
    }
    
    

}

extension ShelfDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getShelfBooksCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if gridState == .list {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListAsListCollectionViewCell.identifier, for: indexPath) as? BookListAsListCollectionViewCell else { return UICollectionViewCell() }
            cell.book = viewModel.getBook(at: indexPath.row)
            cell.delegate = self
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListCollectionViewCell.identifier, for: indexPath) as? BookListCollectionViewCell else { return UICollectionViewCell() }
            cell.book = viewModel.getBook(at: indexPath.row)
            cell.delegate = self
            return cell
        }
    }
    
    
}

extension ShelfDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        if gridState == .list  {
            return CGSize(width: width, height: 100)
        } else if gridState == .largeGrid {
            return CGSize(width: (width-60)/2 , height: 300)
        } else {
            return CGSize(width: (width-60)/3 , height: 230)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToDetail(book: viewModel.getBook(at: indexPath.row))
    }
}

extension ShelfDetailViewController: RadioItemProtocol {
    func onTapRadioItem(index: Layout) {
        gridState = index
        self.bookCollectionView.reloadData()
    }
    
    func onTapRadioForSort(index: SortBy) {
        sortBy = index
        switch index {
        case .recent:
            sortByLbl.text = "Sort by: Recent"
            viewModel.getShelfBooks(sort: "recentlyDate")
        case .title:
            sortByLbl.text = "Sort by: Title"
            viewModel.getShelfBooks(sort: "title")
        case .author:
            sortByLbl.text = "Sort by: Author"
            viewModel.getShelfBooks(sort: "author")
        }
    }
}

extension ShelfDetailViewController: ViewMoreProtocol {
    func clickViewMore(bookVO: BookVO) {
        navigateToMoreActionDelegate(bookVO: bookVO)
    }
}

extension ShelfDetailViewController: YourBooksProtocol {
    func removeDownload(book: BookVO) {
        
    }
    
    func addToShelves(book: BookVO) {
        navigateToAddShelf(book: book)
    }
    
    func readAboutThisBook(book: BookVO) {
        self.navigateToDetail(book: book)
    }
    
    
}

extension ShelfDetailViewController: ShelfUpdateDelegate {
    func isDeleted() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func rename(shelfVO: ShelfVO, isReanme: Bool) {
        navigateToCreateShelf(shelfVO: shelfVO, isReanme: isReanme)
    }
    
    
}
