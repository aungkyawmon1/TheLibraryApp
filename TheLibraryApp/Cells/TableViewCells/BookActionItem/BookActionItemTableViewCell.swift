//
//  BookActionItemTableViewCell.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 30/06/2022.
//

import UIKit

class BookActionItemTableViewCell: UITableViewCell {

    @IBOutlet weak var btnAddToWishlist : UIButton!
    weak var delegate : BookActionItemDelegate? = nil
    
    var isInWishlist: Bool? {
        didSet {
            if let data = isInWishlist {
                btnAddToWishlist.titleLabel?.text = data ? "Delete from Wishlist" : "Add to Wishlist"
                btnAddToWishlist.backgroundColor = data ? .red : .blue
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func addToWishlistBtnClick(_ sender: UIButton) {
        if isInWishlist ?? false {
            delegate?.deleteFromWishlist()
        } else {
            delegate?.addToWishlist()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
