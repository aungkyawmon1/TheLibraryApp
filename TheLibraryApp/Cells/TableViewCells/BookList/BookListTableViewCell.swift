//
//  BookListTableViewCell.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 28/06/2022.
//

import UIKit

class BookListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ivShowMore: UIImageView!
    @IBOutlet weak var bookListCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCells()
    }
    
    private func registerCells() {
        bookListCollectionView.dataSource = self
        bookListCollectionView.delegate = self
        bookListCollectionView.registerForCell(identifier: BookListCollectionViewCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension BookListTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueCell(identifier: BookListCollectionViewCell.identifier, indexPath: indexPath) as? BookListCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}

extension BookListTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: CGFloat(120), height: CGFloat(230))
    }
}
