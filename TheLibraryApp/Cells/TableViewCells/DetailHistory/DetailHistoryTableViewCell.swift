//
//  DetailHistoryTableViewCell.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 28/06/2022.
//

import UIKit
import UPCarouselFlowLayout

class DetailHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var detailHistoryCollectionView: UICollectionView!
    
    weak var delegate: DetailProtocol? = nil
    var recentlyDetailedBooks : [RecentDetailVO]? {
        didSet {
            detailHistoryCollectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    
    func updateUI() {
       // collectionViewCard.isHidden = false
        let layout = UPCarouselFlowLayout()
        layout.itemSize.width = contentView.bounds.width * 0.8
        layout.itemSize.height = 200
        layout.scrollDirection = .horizontal
        layout.sideItemScale = 0.8
        layout.sideItemAlpha = 0.5
        layout.spacingMode = .overlap(visibleOffset: contentView.bounds.width * 0.05)
        detailHistoryCollectionView.collectionViewLayout = layout
        detailHistoryCollectionView.registerForCell(identifier: DetailHistoryCollectionViewCell.identifier)
        detailHistoryCollectionView.dataSource = self
        detailHistoryCollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension DetailHistoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentlyDetailedBooks?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueCell(identifier: DetailHistoryCollectionViewCell.identifier, indexPath: indexPath) as? DetailHistoryCollectionViewCell else { return UICollectionViewCell() }
        cell.image = recentlyDetailedBooks?[indexPath.row].book?.bookImage
        return cell
    }
    
    
}

extension DetailHistoryTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.goToDetail(book: recentlyDetailedBooks?[indexPath.row].book ?? BookVO() )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: CGFloat(250), height: CGFloat(200))
    }
}

