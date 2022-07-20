//
//  BookInfoTableViewCell.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 30/06/2022.
//

import UIKit
import SDWebImage

class BookInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImage : UIImageView!
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var authorLbl : UILabel!
    
    func bindData(image: String, title: String, author: String) {
        bookImage.sd_setImage(with: URL(string: "\(image)"))
        titleLbl.text = title
        authorLbl.text = author
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
