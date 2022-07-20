//
//  RatingsAndReviewsViewController.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 06/07/2022.
//

import UIKit

class RatingsAndReviewsViewController: UIViewController {

    @IBOutlet weak var ratingsAndReviewsTableView : UITableView!
    
    var items: [BookDetailSectionType] = [
        .ratingAndReviews,
        .comments(comment: [
            Comment(comment: "It's June 2022 , Who can suddenly remember & how many legends still listening this Masterpiece"),
            Comment(comment: "I think this song somewhat aligns with the time we all have missed since the pandemic started. I hope someday we all get to sit down all together, get to do the things we used to do pre pandemic and everything. I hope you all are still having a good day. This is a nice song. This song is only showing good vibes. Love it.")
        ])
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }
    
    private func setUpNavBar() {
        
    }
    
    private func setUpTableView() {
        ratingsAndReviewsTableView.dataSource = self
        //ratingsAndReviewsTableView.delegate = self
        ratingsAndReviewsTableView.separatorStyle = .none
        ratingsAndReviewsTableView.showsVerticalScrollIndicator = false
        ratingsAndReviewsTableView.showsHorizontalScrollIndicator = false
        
        ratingsAndReviewsTableView.registerForCell(identifier: RatingAndReviewsTableViewCell.identifier)
        ratingsAndReviewsTableView.registerForCell(identifier: CommentsTableViewCell.identifier)
        
    }

}

extension RatingsAndReviewsViewController: UITableViewDataSource {
    
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
            cell.hideView()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}
