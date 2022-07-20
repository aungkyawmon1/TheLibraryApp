//
//  BookListTableViewCell.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 28/06/2022.
//

import UIKit
import RealmSwift

class BookListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ivShowMore: UIImageView!
    @IBOutlet weak var bookListCollectionView: UICollectionView!
    weak var delegate: ViewMoreProtocol? = nil
    weak var showMoreDelegate: ShowMoreProtocol? = nil
    weak var detailDelegate: DetailProtocol? = nil
    
    private var bookList = List<BookVO>()
    var listVO: ListVO? {
        didSet{
            if let data = listVO {
                lblTitle.text = data.listName
                bookList = data.books
                bookListCollectionView.reloadData()
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCells()
        addGestureForShowMore()
    }
    
    private func registerCells() {
        bookListCollectionView.dataSource = self
        bookListCollectionView.delegate = self
        bookListCollectionView.registerForCell(identifier: BookListCollectionViewCell.identifier)
    }
    
    private func addGestureForShowMore() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapShowMore))
        ivShowMore.addGestureRecognizer(tap)
        ivShowMore.isUserInteractionEnabled = true
    }

    @objc private func onTapShowMore() {
        showMoreDelegate?.tapShowMore(id: listVO?.listID ?? 0, listNameEncoded: listVO?.listNameEncoded ?? "")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension BookListTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueCell(identifier: BookListCollectionViewCell.identifier, indexPath: indexPath) as? BookListCollectionViewCell else { return UICollectionViewCell() }
        cell.delegate = self
        cell.book = bookList[indexPath.row]
        return cell
    }
    
    
}

extension BookListTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        detailDelegate?.goToDetail(book: bookList[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: CGFloat(120), height: CGFloat(230))
    }
}

extension BookListTableViewCell: ViewMoreProtocol {
    func clickViewMore(bookVO: BookVO) {
        
        delegate?.clickViewMore(bookVO: bookVO)
    }
    
}
