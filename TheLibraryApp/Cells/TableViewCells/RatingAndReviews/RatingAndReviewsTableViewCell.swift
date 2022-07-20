//
//  RatingAndReviewsTableViewCell.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 30/06/2022.
//

import UIKit

class RatingAndReviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var forwardIV : UIImageView!
    weak var delegate: DetailProtocol? = nil
    
    
    func hideView() {
        forwardIV.isHidden = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        addGestureForForward()
    }
    
    private func addGestureForForward() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapForward))
        forwardIV.isUserInteractionEnabled = true
        forwardIV.addGestureRecognizer(tap)
    }
  
    
    @objc private func onTapForward() {
        debugPrint("click")
        delegate?.goToDetail(book: BookVO() )
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
