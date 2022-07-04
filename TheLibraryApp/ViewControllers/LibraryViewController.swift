//
//  LibraryViewController.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 27/06/2022.
//

import UIKit

class LibraryViewController: UIViewController {

    @IBOutlet weak var bookCollectionView: UICollectionView!
    private var gridState: Layout = .list
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func registerCells() {
        bookCollectionView.dataSource = self
        bookCollectionView.delegate = self
        bookCollectionView.registerForCell(identifier: BookListCollectionViewCell.identifier)
        bookCollectionView.registerForCell(identifier: BookListAsListCollectionViewCell.identifier)
    }
    

    @IBAction func btnGridClicked(_ sender: UIButton) {
        navigateToViewAsViewController()
    }
    
    func navigateToViewAsViewController(index: Layout = .list) {
        let vc = ViewAsViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        vc.selectedGrid = index
        vc.hidesBottomBarWhenPushed = true
        self.tabBarController?.present(vc, animated: true)
    }
 

}

extension LibraryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if gridState == .list {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListAsListCollectionViewCell.identifier, for: indexPath) as? BookListAsListCollectionViewCell else { return UICollectionViewCell() }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListCollectionViewCell.identifier, for: indexPath) as? BookListCollectionViewCell else { return UICollectionViewCell() }
            return cell
        }
    }
    
    
}

extension LibraryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        if gridState == .list {
            return CGSize(width: width, height: 100)
        } else if gridState == .largeGrid {
            return CGSize(width: (width-60)/2 , height: 300)
        } else {
            return CGSize(width: (width-60)/3 , height: 230)
        }
    }
}

extension LibraryViewController: RadioItemProtocol {
    func onTapRadioItem(index: Layout) {
        gridState = index
        self.bookCollectionView.reloadData()
    }
}
