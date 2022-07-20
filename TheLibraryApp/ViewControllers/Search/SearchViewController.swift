//
//  SearchViewController.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 09/07/2022.
//

import UIKit
import Combine

class SearchViewController: UIViewController {

    @IBOutlet weak var searchCollectionView : UICollectionView!

    lazy var searchBar: UISearchBar = {
       let ui = UISearchBar()
        ui.placeholder = "Search..."
        return ui
    }()
    
    private var viewModel: SearchViewModel!
    private var bag = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchViewModel(searchModel: SearchModel.shared)
    
        
        initState()
    }
    
    private func initState(){
        navigationItem.titleView = searchBar
        
        viewModel.viewState
            .sink { state in
                switch state {
                case .success:
                    self.searchCollectionView.reloadData()
                case .failure(message: let message):
                    debugPrint(message)
                }
            }.store(in: &bag)
        
        registerCells()
        listenForSearchTextChanges()
    }
    
    private func listenForSearchTextChanges() {
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchBar.searchTextField)
        
        let _ = publisher.map({
            ( $0.object as! UISearchTextField).text!
        })
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { (searchText) in
                self.viewModel.fetchData(with: searchText)
            }.store(in: &bag)
    }
    
    private func registerCells() {
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
        searchCollectionView.registerForCell(identifier: BookListAsListCollectionViewCell.identifier)
    }

}


extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getBookCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListAsListCollectionViewCell.identifier, for: indexPath) as? BookListAsListCollectionViewCell else { return UICollectionViewCell() }
        cell.delegate = self
        cell.book = viewModel.getBook(with: indexPath.row)
        return cell
    }
    
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigateToDetail(book: viewModel.getBook(with: indexPath.row))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width , height: 100)
    }
}

extension SearchViewController: ViewMoreProtocol {
    
    func clickViewMore(bookVO: BookVO) {
        navigateToMoreAction(bookVO: bookVO)
    }
}
