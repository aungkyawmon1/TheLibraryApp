//
//  SortByViewController.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 03/07/2022.
//

import UIKit

class SortByViewController: UIViewController {
    @IBOutlet weak var sortTableView: UITableView!
    @IBOutlet weak var viewContainer: UIView!
    
    private let list = ["Recently opened","Title","Author"]
    var selectedGrid = SortBy.recent
    weak var delegate: RadioItemProtocol? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        gestureForViewContainer()
    }
    
    private func setUpTableView() {
        sortTableView.dataSource = self
        sortTableView.delegate = self
        sortTableView.separatorStyle = .none
        sortTableView.showsVerticalScrollIndicator = false
        sortTableView.showsHorizontalScrollIndicator = false
        
        sortTableView.registerForCell(identifier: RadioButtonTableViewCell.identifier)
        
    }
    
    private func gestureForViewContainer() {
        let tapForViewContainer = UITapGestureRecognizer(target: self, action: #selector(onTapViewContainer))
        viewContainer.addGestureRecognizer(tapForViewContainer)
        viewContainer.isUserInteractionEnabled = true
    }
    
    @objc private func onTapViewContainer() {
        dismiss(animated: true)
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
        if selectedGrid.rawValue == indexPath.row {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        }
        return cell
    }
    
    
}

extension SortByViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onTapRadioForSort(index: SortBy(rawValue: indexPath.row) ?? .recent)
    }
}
