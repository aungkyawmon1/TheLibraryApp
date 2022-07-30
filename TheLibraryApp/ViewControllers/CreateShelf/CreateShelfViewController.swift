//
//  CreateShelfViewController.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 02/07/2022.
//

import UIKit
import Combine

class CreateShelfViewController: UIViewController {

    @IBOutlet weak var lblShelfCount: UILabel!
    @IBOutlet weak var tfShelfName: UITextField!
    private var bag = Set<AnyCancellable>()
    
    
    var viewModel = CreateShelfViewModel(shelfModel: ShelfModel.shared, shelfVO: ShelfVO(), isRename: false)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnSave = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(onTapSave))
        self.navigationItem.rightBarButtonItem = btnSave
       initView()
    }
    
    private func initView() {
        viewModel.viewState
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                    
                case .success:
                    self.navigationController?.popViewController(animated: true)
                case .validate(let message):
                    self.lblShelfCount.textColor = .systemGray
                    self.lblShelfCount.text = message
                case .invalidate(let message):
                    self.lblShelfCount.textColor = .red
                    self.lblShelfCount.text = message
                }
            }.store(in: &bag)
        
        if viewModel.isRenameState() {
            tfShelfName.text = viewModel.shelfTitle
        }
        tfShelfName.setUnderLine()
        listenForSearchTextChanges()
    }
    
    @objc func onTapSave() {
        if tfShelfName.text?.count ?? 0 > 0 && tfShelfName.text?.count ?? 51 <= 50 {
            debugPrint("Save")
            if viewModel.isRenameState() {
                viewModel.editShelfTitle(title: tfShelfName.text!)
            }else {
                viewModel.saveShelf(title: tfShelfName.text!)
            }
           
        }
    }
    
    private func listenForSearchTextChanges() {
        let publisher = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: tfShelfName)
    
        let _ = publisher.map({
            ( $0.object as! UITextField).text!
        })
            .sink { (searchText) in
                self.viewModel.validateTitle(title: searchText)
            }.store(in: &bag)
    }

}
