//
//  ShelfUpdateViewController.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 08/07/2022.
//

import UIKit

class ShelfUpdateViewController: UIViewController {

    @IBOutlet weak var viewContainer : UIView!
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var renameView : UIStackView!
    @IBOutlet weak var deleteView : UIStackView!
    
    weak var delegate: ShelfUpdateDelegate? = nil
    
    var viewModel = ShelfUpdateViewModel(shelfModel: ShelfModel.shared, shelfVO: ShelfVO())
    override func viewDidLoad() {
        super.viewDidLoad()

        addGestureForViewContainer()
        addGestureForRename()
        addGestureForDelete()
        titleLbl.text = viewModel.shelfTitle
    }


    private func addGestureForViewContainer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapViewContainer))
        viewContainer.isUserInteractionEnabled = true
        viewContainer.addGestureRecognizer(tap)
    }
    
    private func addGestureForRename() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapRename))
        renameView.isUserInteractionEnabled = true
        renameView.addGestureRecognizer(tap)
    }
    
    private func addGestureForDelete() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapDelete))
        deleteView.isUserInteractionEnabled = true
        deleteView.addGestureRecognizer(tap)
    }

    @objc private func onTapViewContainer() {
        self.dismiss(animated: true)
    }
    
    @objc private func onTapRename() {
        self.dismiss(animated: true)
        delegate?.rename(shelfVO:viewModel.getShelfVO(), isReanme: true)
       
    }
    
    @objc private func onTapDelete() {
        if viewModel.deleteShelf() {
            self.dismiss(animated: true)
            delegate?.isDeleted()
       
        }
    }
}
