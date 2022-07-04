//
//  BookDetailViewController.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 30/06/2022.
//

import UIKit

enum BookDetailSectionType {
    case bookInfo
    case bookActionItem
    case aboutBook
    case ratingAndReviews
    case comments(comment: [Comment])
    case published
}
struct Comment {
    let comment: String
}
class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookDetailTableView: UITableView!
    
    var items: [BookDetailSectionType] = [
        .bookInfo,
        .bookActionItem,
        .aboutBook,
        .ratingAndReviews,
        .comments(comment: [
            Comment(comment: "It's June 2022 , Who can suddenly remember & how many legends still listening this Masterpiece"),
            Comment(comment: "I think this song somewhat aligns with the time we all have missed since the pandemic started. I hope someday we all get to sit down all together, get to do the things we used to do pre pandemic and everything. I hope you all are still having a good day. This is a nice song. This song is only showing good vibes. Love it.")
        ]),
        .published
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpTableView()
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
            return cell
        case .aboutBook:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AboutBookTableViewCell.identifier, for: indexPath) as? AboutBookTableViewCell else { return UITableViewCell() }
            return cell
        case .bookActionItem:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BookActionItemTableViewCell.identifier, for: indexPath) as? BookActionItemTableViewCell else { return UITableViewCell() }
            return cell
        case .bookInfo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BookInfoTableViewCell.identifier, for: indexPath) as? BookInfoTableViewCell else { return UITableViewCell() }
            return cell
        case .published:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PublishedTableViewCell.identifier, for: indexPath) as? PublishedTableViewCell else { return UITableViewCell() }
            return cell
        }
    }
    
    
}

extension BookDetailViewController: UITableViewDelegate {
    
}
