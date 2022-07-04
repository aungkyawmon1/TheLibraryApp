//
//  ImageBarButton.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 27/06/2022.
//
import UIKit

class ImageBarButton : UIView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 40 / 2
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.backgroundColor = .clear
        button.setTitle("", for: .normal)
        return button
    }()

    convenience init(withUrl imageURL: URL? = nil, withImage image: UIImage? = nil, frame: CGRect = CGRect(x: 0, y: 0, width: 40, height: 40)) {
        self.init(frame: frame)
        addSubview(imageView)
        addSubview(button)

        if let url = imageURL { // you can use pods like Nuke or Kingfisher
         URLSession(configuration: .default).dataTask(with: url) {[weak self] (data, response, error) in
          if let data = data , let image = UIImage(data: data) {
              DispatchQueue.main.async {
                self?.imageView.image = image
              }
           }
         }.resume()
        } else if let image = image {
            self.imageView.image = image
        }
    }

    func load()-> UIBarButtonItem {
        return UIBarButtonItem(customView: self)
    }
}
