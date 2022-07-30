//
//  AddToShelfTableViewCell.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 03/07/2022.
//

import UIKit

class AddToShelfTableViewCell: UITableViewCell {

    @IBOutlet weak var lblShelfName: UILabel!
    @IBOutlet weak var lblBookCount: UILabel!
    @IBOutlet weak var btnCheckmark: UIButton!
    
    var shelf: ShelfVO? {
        didSet {
            if let data = shelf {
                lblShelfName.text = data.shelfTitle
                lblBookCount.text = data.book.count > 0 ? "\(data.book.count) Books" : "\(data.book.count) Book"
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        if selected {
//            btnCheckmark.isSelected = true
//        } else {
//            btnCheckmark.isSelected = false
//        }
    }
    
}
