//
//  BookListAsListCollectionViewCell.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 03/07/2022.
//

import UIKit

class BookListAsListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bookCoverIV: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var sampleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var viewMore : UIImageView!
    
    weak var delegate: ViewMoreProtocol? = nil
    var book: BookVO? {
        didSet {
            if let data = book {
                titleLbl.text = data.title
                authorLbl.text = data.author
                bookCoverIV.sd_setImage(with: URL(string: "\(data.bookImage ?? "https://www.sharetee.org/lightIdea/jk-placeholder-image.jpg")"))
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addGestureForViewMore()
    }
    
    private func addGestureForViewMore() {
        let tapViewMore = UITapGestureRecognizer(target: self, action: #selector(onTapViewMore))
        viewMore.addGestureRecognizer(tapViewMore)
        viewMore.isUserInteractionEnabled = true
    }
    
    @objc private func onTapViewMore() {
        delegate?.clickViewMore(bookVO: book ?? BookVO())
    }

}
