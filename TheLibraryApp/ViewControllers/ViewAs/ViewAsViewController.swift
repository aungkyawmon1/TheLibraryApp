//
//  ViewAsViewController.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 02/07/2022.
//

import UIKit

class ViewAsViewController: UIViewController {

    @IBOutlet weak var radioTableView: UITableView!
    @IBOutlet weak var viewContainer: UIView!
    private let list = ["List","Large grid","Small grid"]
    var selectedGrid: Layout = .list
    var delegate: RadioItemProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gestureForViewContainer()
        setUpTableView()
    }
    
  
    
    private func setUpTableView() {
        radioTableView.dataSource = self
        radioTableView.delegate = self
        radioTableView.separatorStyle = .none
        radioTableView.showsVerticalScrollIndicator = false
        radioTableView.showsHorizontalScrollIndicator = false
        
        radioTableView.registerForCell(identifier: RadioButtonTableViewCell.identifier)
        
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

extension ViewAsViewController: UITableViewDataSource {
    
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
            //tableView.setSelected(true, animated: true)
        }
        return cell
    }
}

extension ViewAsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onTapRadioItem(index: Layout(rawValue: indexPath.row) ?? .list)
    }
}
