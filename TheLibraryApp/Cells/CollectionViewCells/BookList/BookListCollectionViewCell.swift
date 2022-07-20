//
//  BookListCollectionViewCell.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 28/06/2022.
//

import UIKit
import SDWebImage

class BookListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivBookImage: UIImageView!
    @IBOutlet weak var moreOptionContainer: UIView!
    @IBOutlet weak var viewMore : UIView!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblAuthor : UILabel!
    weak var delegate: ViewMoreProtocol? = nil
    var book: BookVO? {
        didSet {
            if let data = book {
                lblTitle.text = data.title
                lblAuthor.text = data.author
                ivBookImage.sd_setImage(with: URL(string: "\(data.bookImage ?? "https://www.sharetee.org/lightIdea/jk-placeholder-image.jpg")"))
            }
        }
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        gestureRecognizerForViewMore()
    }
    
    private func gestureRecognizerForViewMore() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapViewMore))
        viewMore.isUserInteractionEnabled = true
        viewMore.addGestureRecognizer(tap)
    }

    @objc private func onTapViewMore() {
        delegate?.clickViewMore(bookVO: book ?? BookVO() )
    }
}
