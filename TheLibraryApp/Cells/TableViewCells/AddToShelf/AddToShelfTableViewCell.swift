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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            btnCheckmark.isSelected = true
        } else {
            btnCheckmark.isSelected = false
        }
    }
    
}
