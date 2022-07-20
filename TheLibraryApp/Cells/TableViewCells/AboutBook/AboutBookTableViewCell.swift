//
//  AboutBookTableViewCell.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 30/06/2022.
//

import UIKit

class AboutBookTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLbl : UILabel!
    
    var bookDescription : String? {
        didSet {
            if let data = bookDescription {
                descriptionLbl.text = data
            }
        }
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
