//
//  View+Extension.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 28/06/2022.
//

import UIKit


extension UITableViewCell {
    static var identifier : String {
        String(describing: self)
    }
}

extension UICollectionViewCell {
    static var identifier : String {
        String(describing: self)
    }
}

extension UIViewController {
    static var identifier : String {
        String(describing: self)
    }
}

extension UITableView {
    
    func registerForCell(identifier : String){
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func dequeueCell<T:UITableViewCell>(identifier: String, indexPath : IndexPath)->T {
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            return UITableViewCell() as! T
        }
        return cell
    }
}


extension UICollectionView {
    
    func registerForCell(identifier : String){
       register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueCell<T:UICollectionViewCell>(identifier: String, indexPath : IndexPath)->T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            return UICollectionViewCell() as! T
        }
        return cell
    }
}

