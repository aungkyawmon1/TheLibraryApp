//
//  AddToShelfViewController.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 04/07/2022.
//

import UIKit
import Combine
class AddToShelfViewController: UIViewController {

    @IBOutlet weak var btnCreateShelf: UIButton!
    @IBOutlet weak var shelfTableView: UITableView!
    @IBOutlet weak var lblToastMessage : UILabel!
    @IBOutlet weak var toastViewContainer : UIView!
    
    var viewModel = AddToShelfViewModel(shelfModel: ShelfModel.shared, book: BookVO() )
    private var bag = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add to Shelf"
        setUpTableView()
        
        viewModel.viewState
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .noShelf:
                    self.btnCreateShelf.isHidden = false
                case .success:
                    self.navigationController?.popViewController(animated: true)
                case .failure:
                    debugPrint("fail")
                case .shelvesExist:
                    self.btnCreateShelf.isHidden = true
                    self.shelfTableView.reloadData()
                }
            }.store(in: &bag)
        
        viewModel.getShelf()
        btnCreateShelf.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    }
    
    
    @IBAction func createShelfClicked(_ sender: UIButton) {
        navigateToCreateShelf()
    }
    
    private func setUpTableView() {
        shelfTableView.dataSource = self
        shelfTableView.delegate = self
        shelfTableView.separatorStyle = .none
        shelfTableView.showsVerticalScrollIndicator = false
        shelfTableView.showsHorizontalScrollIndicator = false
        
        shelfTableView.registerForCell(identifier: AddToShelfTableViewCell.identifier)
        
    }
    
    fileprivate func showToast(message : String) {
        toastViewContainer.isHidden = false
        lblToastMessage.text = message
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            self.toastViewContainer.alpha = 1.0
        }) { (true) in
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
                self.toastViewContainer.alpha = 0.0
            }) { (result) in
                self.toastViewContainer.isHidden = true
                //toastViewContainer.removeFromSuperview()
            }
        }
        
    }
    
}

extension AddToShelfViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfShelf()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddToShelfTableViewCell.identifier, for: indexPath) as? AddToShelfTableViewCell else { return UITableViewCell() }
        cell.shelf = viewModel.getShelfAtIndex(with: indexPath.row)
        return cell
    }
    
    
}

extension AddToShelfViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.isInShelfBook(with: indexPath.row) {
            showToast(message: "\(viewModel.bookTitle ?? "") is already exit in \(viewModel.getShelfTitle(with: indexPath.row))")
        } else {
            viewModel.saveShelfBook(shelf: viewModel.getShelfAtIndex(with: indexPath.row))
        }
    }
}
