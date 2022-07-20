//
//  MoreActionViewController.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 29/06/2022.
//

import UIKit
import SDWebImage

class MoreActionViewController: UIViewController {

    @IBOutlet weak var viewContainer : UIView!
    @IBOutlet weak var downloadSV : UIStackView!
    @IBOutlet weak var deleteFromWishlistSV : UIStackView!
    @IBOutlet weak var addToShelfSV : UIStackView!
    @IBOutlet weak var addToWishlist : UIStackView!
    @IBOutlet weak var aboutThisBook : UIStackView!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblAuthor : UILabel!
    @IBOutlet weak var ivBookCover : UIImageView!
    
    var viewModel = MoreActionViewModel(bookModel: BookModel.shared, bookVO: BookVO() )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetUp()
        
    }
    
    private func initSetUp() {
        lblTitle.text = viewModel.title
        lblAuthor.text = viewModel.author
        ivBookCover.sd_setImage(with: URL(string: viewModel.bookCover))
        
        if viewModel.isInWishlist() {
            addToWishlist.isHidden = true
        }else {
            deleteFromWishlistSV.isHidden = true
        }
        
        addGestureForViewContainer()
        addGestureForDownload()
        addGestureForShelf()
        addGestureForAbout()
        addGestureForWishlist()
        addGestureForRemoveFromWishlist()
    }

    private func addGestureForViewContainer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapViewContainer))
        viewContainer.isUserInteractionEnabled = true
        viewContainer.addGestureRecognizer(tap)
    }
    
    private func addGestureForDownload() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapDownload))
        downloadSV.isUserInteractionEnabled = true
        downloadSV.addGestureRecognizer(tap)
    }
    
    private func addGestureForRemoveFromWishlist() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapDelete))
        deleteFromWishlistSV.isUserInteractionEnabled = true
        deleteFromWishlistSV.addGestureRecognizer(tap)
    }
    
    private func addGestureForShelf() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapShelf))
        addToShelfSV.isUserInteractionEnabled = true
        addToShelfSV.addGestureRecognizer(tap)
    }
    
    private func addGestureForAbout() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapAbout))
        aboutThisBook.isUserInteractionEnabled = true
        aboutThisBook.addGestureRecognizer(tap)
    }
    
    private func addGestureForWishlist() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapWishlist))
        addToWishlist.isUserInteractionEnabled = true
        addToWishlist.addGestureRecognizer(tap)
    }

    @objc private func onTapViewContainer() {
        self.dismiss(animated: true)
    }
    
    @objc private func onTapDownload() {
        
    }
    
    @objc private func onTapWishlist() {
        if viewModel.addToWishlist() {
            debugPrint("Add to wishlist success")
            deleteFromWishlistSV.isHidden = false
            addToWishlist.isHidden = true
        }else {
            debugPrint("Add to wishlist fail")
        }
    }
    
    @objc private func onTapAbout() {
        navigateToDetail(book: viewModel.book)
    }
    
    @objc private func onTapDelete() {
        if viewModel.removeFromWishlist() {
            addToWishlist.isHidden = false
            deleteFromWishlistSV.isHidden = true
        }else {
            debugPrint("delete to wishlist fail")
        }
    }
    
    @objc private func onTapShelf() {
        
    }
}
