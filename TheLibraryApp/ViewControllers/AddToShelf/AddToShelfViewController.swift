//
//  AddToShelfViewController.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 04/07/2022.
//

import UIKit

class AddToShelfViewController: UIViewController {

    @IBOutlet weak var shelfTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    private func setUpTableView() {
        shelfTableView.dataSource = self
       // shelfTableView.delegate = self
        shelfTableView.separatorStyle = .none
        shelfTableView.showsVerticalScrollIndicator = false
        shelfTableView.showsHorizontalScrollIndicator = false
        
        shelfTableView.registerForCell(identifier: AddToShelfTableViewCell.identifier)
        
    }
}

extension AddToShelfViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddToShelfTableViewCell.identifier, for: indexPath) as? AddToShelfTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    
}

