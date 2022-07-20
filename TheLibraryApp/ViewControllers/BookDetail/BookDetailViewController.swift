//
//  BookDetailViewController.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 30/06/2022.
//

import UIKit


class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookDetailTableView: UITableView!
    
    var selectedBook = BookVO()
    private var bookModel: BookModelProtocol = BookModel.shared
    var items = [BookDetailSectionType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        items = [
            .bookInfo(image: selectedBook.bookImage ?? "", title: selectedBook.title ?? "", author: selectedBook.author ?? ""),
            .bookActionItem,
            .aboutBook(description: selectedBook.bookDescription ?? "" ),
            .ratingAndReviews,
            .comments(comment: [
                Comment(comment: "It's June 2022 , Who can suddenly remember & how many legends still listening this Masterpiece"),
                Comment(comment: "I think this song somewhat aligns with the time we all have missed since the pandemic started. I hope someday we all get to sit down all together, get to do the things we used to do pre pandemic and everything. I hope you all are still having a good day. This is a nice song. This song is only showing good vibes. Love it.")
            ]),
            .published
        ]
        setUpTableView()
        
        let recentlyDetailedBook = RecentDetailVO()
        recentlyDetailedBook.primaryIsbn13 = selectedBook.primaryIsbn13
        recentlyDetailedBook.recentlyDate = Date()
        recentlyDetailedBook.book = selectedBook
        bookModel.saveRecentlyDetailedbooks(data: recentlyDetailedBook)
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
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch items[section] {
        case .comments(let comments):
            return comments.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemType = items[indexPath.section]
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
        case .bookActionItem:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BookActionItemTableViewCell.identifier, for: indexPath) as? BookActionItemTableViewCell else { return UITableViewCell() }
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
