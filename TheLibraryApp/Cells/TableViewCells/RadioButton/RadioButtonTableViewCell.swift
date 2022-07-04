//
//  RadioButtonTableViewCell.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 03/07/2022.
//

import UIKit

class RadioButtonTableViewCell: UITableViewCell {

    
    @IBOutlet weak var btnRadio: UIButton!
    @IBOutlet weak var lblName: UILabel!
    
    func bindData(name: String) {
        lblName.text = name
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            btnRadio.isSelected = true
        }else {
            btnRadio.isSelected = false
        }
    }
    
}
