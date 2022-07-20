//
//  HomeViewController.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 27/06/2022.
//

import UIKit
import Combine

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    var bag = Set<AnyCancellable>()
    private var viewModel : HomeViewModel!
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Play Books"
        return searchBar
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = HomeViewModel(bookModel: BookModel.shared)
        viewModel.viewState.sink { homeViewState in
            switch homeViewState {
            case .success(let sectionType):
                switch sectionType {
                case .RecentlyOpenedItems(_):
                    self.homeTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                case .CategorySelection:
                    debugPrint("CategorySelection")
                case .ItemList(_):
                    self.homeTableView.reloadData()
                }
            case .failure(let message):
                debugPrint(message)
            }
        }.store(in: &bag)
        
        viewModel.fetchAllData()
        
        initState()
        setUpTableView()
        
    }
    
    private func setUpTableView() {
        homeTableView.dataSource = self
        //homeTableView.delegate = self
        homeTableView.separatorStyle = .none
        homeTableView.showsVerticalScrollIndicator = false
        homeTableView.showsHorizontalScrollIndicator = false
        
        homeTableView.registerForCell(identifier: BookListTableViewCell.identifier)
        homeTableView.registerForCell(identifier: CategorySectionTableViewCell.identifier)
        homeTableView.registerForCell(identifier: DetailHistoryTableViewCell.identifier)
    }
    
    private func initState() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        let searchBarButtonView = ImageBarButton(withImage: #imageLiteral(resourceName: "profile")) // Assets
        navigationItem.rightBarButtonItems = [searchBarButtonView.load()]
    }
    
    @objc func profileButtonClicked() {
        
    }
    

}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.getSectionCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNubmerOfRowInSection(sectionType: viewModel.getItemSection(section))
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemType = viewModel.getItemSection(indexPath.section)
        switch itemType {
        case .ItemList(let listVO):
            guard let cell = tableView.dequeueCell(identifier: BookListTableViewCell.identifier, indexPath: indexPath) as? BookListTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.detailDelegate = self
            cell.showMoreDelegate = self
            cell.listVO = listVO[indexPath.row]
            return cell
        case .CategorySelection:
            guard let cell = tableView.dequeueCell(identifier: CategorySectionTableViewCell.identifier, indexPath: indexPath) as? CategorySectionTableViewCell else { return UITableViewCell() }
            return cell
        case .RecentlyOpenedItems(let list):
            guard let cell = tableView.dequeueCell(identifier: DetailHistoryTableViewCell.identifier, indexPath: indexPath) as? DetailHistoryTableViewCell else { return UITableViewCell() }
            cell.recentlyDetailedBooks = list
            return cell
        }
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: ViewMoreProtocol {
    func clickViewMore(bookVO: BookVO) {
        navigateToMoreAction(bookVO: bookVO)
    }
}


extension HomeViewController: DetailProtocol {
    func goToDetail(book: BookVO) {
        self.navigateToDetail(book: book)
    }
}

extension HomeViewController: ShowMoreProtocol {
    func tapShowMore(id: Int, listNameEncoded: String) {
        self.navigateToShowMore(id, listNameEncoded)
    }
}


extension HomeViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        navigateToSearch()
        return false
    }
}
