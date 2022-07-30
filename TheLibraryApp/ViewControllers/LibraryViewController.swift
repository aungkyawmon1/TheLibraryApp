//
//  LibraryViewController.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 27/06/2022.
//

import UIKit
import Combine

class LibraryViewController: UIViewController {

    @IBOutlet weak var bookCollectionView: UICollectionView!
    @IBOutlet weak var lblSortBy: UILabel!
    @IBOutlet weak var yourBooksView: UIView!
    @IBOutlet weak var svHeader: UIStackView!
    @IBOutlet weak var yourShelvesView: UIView!
    @IBOutlet weak var yourShelvesBar: UIView!
    @IBOutlet weak var yourBooksBar: UIView!
    @IBOutlet weak var sortAndGridView: UIView!
    @IBOutlet weak var btnCreateNew : UIButton!
    @IBOutlet weak var noShelvesSV : UIStackView!
    
    private var isYourBookSection = true
    private var viewModel: LibraryViewModel?
    private var bag = Set<AnyCancellable>()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Play Books"
      //  searchBar.setImage(UIImage(named: "profile"), for: .search, state: .normal)
        return searchBar
    }()
    
    private var gridState: Layout = .list
    private var sortBy: SortBy = .recent
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        initState()
        
        viewModel = LibraryViewModel(bookModel: BookModel.shared, shelfModel: ShelfModel.shared)
        
        viewModel?.viewState
            .sink(receiveValue: { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .success:
                    self.bookCollectionView.reloadData()
                case .failure(let message):
                    debugPrint(message)
                }
            }).store(in: &bag)
        
        viewModel?.fetchWishlist(sort: "recentlyDate")
        //viewModel?.getShelf()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel?.getShelf()
    }

    
    private func initState() {
        searchBar.delegate = self
        
        navigationItem.titleView = searchBar
        let searchBarButtonView = ImageBarButton(withImage: #imageLiteral(resourceName: "profile")) // Assets
        //searchBarButtonView.button.addTarget(self, action: #selector(presentSearchViewController), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [searchBarButtonView.load()]
        
        btnCreateNew.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        addGestureForYourBooks()
        addGestureForYourShelves()
    }
    
    private func addGestureForYourBooks() {
        let yourBooks = UITapGestureRecognizer(target: self, action: #selector(onTapYourBooks))
        yourBooksView.addGestureRecognizer(yourBooks)
        yourBooksView.isUserInteractionEnabled = true
    }
    
    private func addGestureForYourShelves() {
        let yourShelves = UITapGestureRecognizer(target: self, action: #selector(onTapYourShelves))
        yourShelvesView.addGestureRecognizer(yourShelves)
        yourShelvesView.isUserInteractionEnabled = true
    }
    
    @objc private func onTapYourBooks() {
        yourBooksBar.backgroundColor = UIColor(named: "colorPrimary") ?? .tintColor
        yourShelvesBar.backgroundColor = .systemGray5
        sortAndGridView.isHidden = false
        btnCreateNew.isHidden = true
        noShelvesSV.isHidden = true
        isYourBookSection = true
        bookCollectionView.reloadData()
    }
    
    @objc private func onTapYourShelves() {
        yourShelvesBar.backgroundColor = UIColor(named: "colorPrimary") ?? .tintColor
        yourBooksBar.backgroundColor = .systemGray5
        sortAndGridView.isHidden = true
        btnCreateNew.isHidden = false
        //noShelvesSV.isHidden = false
        isYourBookSection = false
        bookCollectionView.reloadData()
    }
    
    @objc private func presentSearchViewControll() {
        navigateToSearch()
    }
    
    private func registerCells() {
        bookCollectionView.dataSource = self
        bookCollectionView.delegate = self
        bookCollectionView.registerForCell(identifier: BookListCollectionViewCell.identifier)
        bookCollectionView.registerForCell(identifier: BookListAsListCollectionViewCell.identifier)
        bookCollectionView.registerForCell(identifier: ShelfCollectionViewCell.identifier)
    }
    

    @IBAction func btnGridClicked(_ sender: UIButton) {
        navigateToViewAsViewController(index: gridState)
    }
    
    @IBAction func btnCreateNew(_ sender: UIButton) {
        navigateToCreateShelf()
    }
    
    
    @IBAction func btnSortClick(_ sender: Any) {
        navigateToSortBy(index: sortBy)
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
    
    
    func navigateToMoreActionDelegate(bookVO: BookVO) {
        let vc = MoreActionViewController()
        vc.delegate = self
        vc.viewModel = MoreActionViewModel(bookModel: BookModel.shared, bookVO: bookVO)
        vc.modalPresentationStyle = .overCurrentContext
        self.tabBarController?.present(vc, animated: true)
    }
    

}

extension LibraryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isYourBookSection {
            return viewModel?.getWishlistCount() ?? 0
        } else {
            return viewModel?.getShelfCount() ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isYourBookSection {
            if gridState == .list {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListAsListCollectionViewCell.identifier, for: indexPath) as? BookListAsListCollectionViewCell else { return UICollectionViewCell() }
                cell.book = viewModel?.getWishlist(at: indexPath.row)
                cell.delegate = self
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListCollectionViewCell.identifier, for: indexPath) as? BookListCollectionViewCell else { return UICollectionViewCell() }
                cell.delegate = self
                cell.book = viewModel?.getWishlist(at: indexPath.row)
                return cell
            }
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShelfCollectionViewCell.identifier, for: indexPath) as? ShelfCollectionViewCell else { return UICollectionViewCell() }
            cell.shelf = viewModel?.getShelf(at: indexPath.row)
            return cell
        }
    }
    
    
}

extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if(scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0) && isYourBookSection {
//            sortAndGridView.isHidden = false
//        }
//        else {
//            sortAndGridView.isHidden = true
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isYourBookSection {
            navigateToDetail(book: viewModel?.getWishlist(at: indexPath.row) ?? BookVO() )
        } else {
            navigateToShelfDetail(shelfVO: viewModel?.getShelf(at: indexPath.row) ?? ShelfVO() )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        if isYourBookSection {
            if gridState == .list  {
                return CGSize(width: width, height: 100)
            } else if gridState == .largeGrid {
                return CGSize(width: (width-50)/2 , height: 300)
            } else {
                return CGSize(width: (width-80)/3 , height: 230)
            }
        }else {
            return CGSize(width: width, height: 120)
        }
    }
}

extension LibraryViewController: RadioItemProtocol {
    func onTapRadioForSort(index: SortBy) {
        sortBy = index
        switch index {
        case .recent:
            lblSortBy.text = "Sort by: Recent"
            viewModel?.fetchWishlist(sort: "recentlyDate")
        case .title:
            lblSortBy.text = "Sort by: Title"
            viewModel?.fetchWishlist(sort: "title")
        case .author:
            lblSortBy.text = "Sort by: Author"
            viewModel?.fetchWishlist(sort: "author")
        }
        
    }
    
    func onTapRadioItem(index: Layout) {
        gridState = index
        self.bookCollectionView.reloadData()
    }
}

extension LibraryViewController: ViewMoreProtocol {
    func clickViewMore(bookVO: BookVO) {
        navigateToMoreActionDelegate(bookVO: bookVO)
    }
}

extension LibraryViewController: YourBooksProtocol {
    func removeDownload(book: BookVO) {
        
    }
    
    func addToShelves(book: BookVO) {
        navigateToAddShelf()
    }
    
    func readAboutThisBook(book: BookVO) {
        navigateToDetail(book: book)
    }
}

extension LibraryViewController: DetailProtocol {
    func goToDetail(book: BookVO) {
        navigateToDetail(book: book)
    }
    
    
}

extension LibraryViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        navigateToSearch()
        return false
    }
}
