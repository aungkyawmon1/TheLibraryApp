//
//  BookDetailViewController.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 30/06/2022.
//

import UIKit
import Combine

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookDetailTableView: UITableView!
    private var bag = Set<AnyCancellable>()
    
    var viewModel = BookDetailViewModel(bookModel: BookModel.shared, bookVO: BookVO())
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        viewModel.viewState
            .sink { state in
                switch state {
                case .bookAction:
                    self.bookDetailTableView.reloadSections(IndexSet(integer: 1), with: .automatic)
                }
            }.store(in: &bag)
    
        viewModel.saveToRecentlyDetailedBook()
        
    }

    private func setUpTableView() {
        bookDetailTableView.dataSource = self
        bookDetailTableView.delegate = self
        bookDetailTableView.separatorStyle = .none
        bookDetailTableView.showsVerticalScrollIndicator = false
        bookDetailTableView.showsHorizontalScrollIndicator = false
        
        bookDetailTableView.registerForCell(identifier: BookInfoTableViewCell.identifier)
        bookDetailTableView.registerForCell(identifier: BookActionItemTableViewCell.identifier)
        bookDetailTableView.registerForCell(identifier: AboutBookTableViewCell.identifier)
        bookDetailTableView.registerForCell(identifier: RatingAndReviewsTableViewCell.identifier)
        bookDetailTableView.registerForCell(identifier: CommentsTableViewCell.identifier)
        bookDetailTableView.registerForCell(identifier: PublishedTableViewCell.identifier)
    }

}

extension BookDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getItemCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNubmerOfRowInSection(sectionType: viewModel.getItemSection(section))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemType = viewModel.getItemSection(indexPath.section)
        switch itemType {
        case .comments(_):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.identifier, for: indexPath) as? CommentsTableViewCell else { return UITableViewCell() }
            return cell
        case .ratingAndReviews:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RatingAndReviewsTableViewCell.identifier, for: indexPath) as? RatingAndReviewsTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            return cell
        case .aboutBook(let description):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AboutBookTableViewCell.identifier, for: indexPath) as? AboutBookTableViewCell else { return UITableViewCell() }
            cell.bookDescription = description
            return cell
        case .bookActionItem(_):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BookActionItemTableViewCell.identifier, for: indexPath) as? BookActionItemTableViewCell else { return UITableViewCell() }
            cell.isInWishlist = viewModel.isInWishlist()
            cell.delegate = self
            return cell
        case .bookInfo(let image, let title, let author):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BookInfoTableViewCell.identifier, for: indexPath) as? BookInfoTableViewCell else { return UITableViewCell() }
            cell.bindData(image: image, title: title, author: author)
            return cell
        case .published:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PublishedTableViewCell.identifier, for: indexPath) as? PublishedTableViewCell else { return UITableViewCell() }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}

extension BookDetailViewController: UITableViewDelegate {
    
}

extension BookDetailViewController: DetailProtocol {
    func goToDetail(book: BookVO) {
        self.navigateToRatingsAndReviews()
    }
}

extension BookDetailViewController: BookActionItemDelegate {
    
    func addToWishlist() {
        viewModel.notifyBookActionItem(isInWishlist: viewModel.addToWishlist())
    }
    
    func deleteFromWishlist() {
        viewModel.notifyBookActionItem(isInWishlist: !viewModel.removeFromWishlist() )
    }
}
