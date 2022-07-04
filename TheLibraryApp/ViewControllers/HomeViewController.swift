//
//  HomeViewController.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 27/06/2022.
//

import UIKit

enum HomeViewControllerSectionType {
    case RecentlyOpenedItems
    case CategorySelection
    case ItemList(items: [BookListItem])
}

struct BookListItem {
    let title: String
    let books: [Item]
    
    struct Item {
        let image: String
        let title: String
        let id: Int
    }
}

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    
    var items: [HomeViewControllerSectionType] = [
        .RecentlyOpenedItems,
        .CategorySelection,
        .ItemList(items: [
            BookListItem(title: "2022 Best Selling Books", books: [ BookListItem.Item ]() ),
            BookListItem(title: "2022 Best Selling Books", books: [ BookListItem.Item ]() ),
            BookListItem(title: "2022 Best Selling Books", books: [ BookListItem.Item ]() ),
            BookListItem(title: "2022 Best Selling Books", books: [ BookListItem.Item ]() ),
        ])
    ]
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Play Books"
      //  searchBar.setImage(UIImage(named: "profile"), for: .search, state: .normal)
        return searchBar
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        initState()
       setUpTableView()
    }
    
    private func setUpTableView() {
        homeTableView.dataSource = self
        homeTableView.delegate = self
        homeTableView.separatorStyle = .none
        homeTableView.showsVerticalScrollIndicator = false
        homeTableView.showsHorizontalScrollIndicator = false
        
        homeTableView.registerForCell(identifier: BookListTableViewCell.identifier)
        homeTableView.registerForCell(identifier: CategorySectionTableViewCell.identifier)
        homeTableView.registerForCell(identifier: DetailHistoryTableViewCell.identifier)
    }
    
    private func initState() {
        navigationItem.titleView = searchBar
        let searchBarButtonView = ImageBarButton(withImage: #imageLiteral(resourceName: "profile")) // Assets
        //searchBarButtonView.button.addTarget(self, action: #selector(presentSearchViewController), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [searchBarButtonView.load()]
    }
    
    @objc func profileButtonClicked() {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch items[section] {
        case .ItemList(let items):
            return items.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemType = items[indexPath.section]
        switch itemType {
        case .ItemList(_):
            guard let cell = tableView.dequeueCell(identifier: BookListTableViewCell.identifier, indexPath: indexPath) as? BookListTableViewCell else { return UITableViewCell() }
            return cell
        case .CategorySelection:
            guard let cell = tableView.dequeueCell(identifier: CategorySectionTableViewCell.identifier, indexPath: indexPath) as? CategorySectionTableViewCell else { return UITableViewCell() }
            return cell
        case .RecentlyOpenedItems:
            guard let cell = tableView.dequeueCell(identifier: DetailHistoryTableViewCell.identifier, indexPath: indexPath) as? DetailHistoryTableViewCell else { return UITableViewCell() }
            return cell
        }
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    
}
