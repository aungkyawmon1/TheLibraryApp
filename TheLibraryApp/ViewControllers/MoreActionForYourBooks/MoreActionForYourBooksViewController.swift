//
//  MoreActionForYourBooksViewController.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 09/07/2022.
//

import UIKit

class MoreActionForYourBooksViewController: UIViewController {

    @IBOutlet weak var viewContainer : UIView!
    @IBOutlet weak var addToShelvesSV : UIStackView!
    @IBOutlet weak var removeDownloadSV : UIStackView!
    @IBOutlet weak var aboutThisBookSV : UIStackView!
    
    weak var delegate: YourBooksProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSetUp()
    }
    
    private func initSetUp() {
        addGestureForViewContainer()
        addGestureForAddToShelves()
        addGestureForRemoveDownload()
        addGestureForAboutThisBook()
    }

    private func addGestureForViewContainer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapViewContainer))
        viewContainer.isUserInteractionEnabled = true
        viewContainer.addGestureRecognizer(tap)
    }
    
    private func addGestureForRemoveDownload() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapRemoveDownload))
        removeDownloadSV.isUserInteractionEnabled = true
        removeDownloadSV.addGestureRecognizer(tap)
    }
    
    private func addGestureForAddToShelves() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapAddToShelves))
        addToShelvesSV.isUserInteractionEnabled = true
        addToShelvesSV.addGestureRecognizer(tap)
    }
    
    private func addGestureForAboutThisBook() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapAboutThisBook))
        aboutThisBookSV.isUserInteractionEnabled = true
        aboutThisBookSV.addGestureRecognizer(tap)
    }

    @objc private func onTapViewContainer() {
        self.dismiss(animated: true)
    }
    
    @objc private func onTapAddToShelves() {
        self.delegate?.addToShelves(id: "")
        self.dismiss(animated: true)
       
    }
    
    @objc private func onTapRemoveDownload() {
        self.delegate?.removeDownload(id: "")
        self.dismiss(animated: true)
    }
    
    @objc private func onTapAboutThisBook() {
        self.delegate?.readAboutThisBook(id: "")
        self.dismiss(animated: true)
    }
}
