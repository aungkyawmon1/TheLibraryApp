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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addGestureForViewContainer()
    }


    private func addGestureForViewContainer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapViewContainer))
        viewContainer.isUserInteractionEnabled = true
        viewContainer.addGestureRecognizer(tap)
    }

    @objc private func onTapViewContainer() {
        self.dismiss(animated: true)
    }
}
