//
//  SortByViewController.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 03/07/2022.
//

import UIKit

class SortByViewController: UIViewController {
    @IBOutlet weak var sortTableView: UITableView!
    
    let list = ["Recently opened","Title","Author"]
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }
    
    private func setUpTableView() {
        sortTableView.dataSource = self
        sortTableView.delegate = self
        sortTableView.separatorStyle = .none
        sortTableView.showsVerticalScrollIndicator = false
        sortTableView.showsHorizontalScrollIndicator = false
        
        sortTableView.registerForCell(identifier: RadioButtonTableViewCell.identifier)
        
    }

}

extension SortByViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RadioButtonTableViewCell.identifier, for: indexPath) as? RadioButtonTableViewCell else { return UITableViewCell() }
        cell.bindData(name: list[indexPath.row])
        return cell
    }
    
    
}

extension SortByViewController: UITableViewDelegate {
    
}
