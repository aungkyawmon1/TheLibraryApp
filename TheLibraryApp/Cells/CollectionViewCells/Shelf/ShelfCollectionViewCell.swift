//
//  ShelfCollectionViewCell.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 08/07/2022.
//

import UIKit
import SDWebImage

class ShelfCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblShelfTitle: UILabel!
    @IBOutlet weak var lblBookCount: UILabel!
    @IBOutlet weak var ivShelfImage: UIImageView!
    
    var shelf: ShelfVO? {
        didSet {
            if let data = shelf {
                lblBookCount.text = data.book.count > 0 ? "\(data.book.count) Books" : "\(data.book.count) Book"
                lblShelfTitle.text = data.shelfTitle
                ivShelfImage.sd_setImage(with: URL(string: data.image ?? "https://www.sharetee.org/lightIdea/jk-placeholder-image.jpg"))
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
