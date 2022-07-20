//
//  DetailHistoryCollectionViewCell.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 28/06/2022.
//

import UIKit
import SDWebImage

class DetailHistoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bookImage : UIImageView!
    
    var image: String? {
        didSet {
            if let data = image {
                bookImage.sd_setImage(with: URL(string: data))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
