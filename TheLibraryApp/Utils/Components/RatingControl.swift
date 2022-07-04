//
//  RatingStar.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 30/06/2022.
//
import UIKit

@IBDesignable
class RatingControl: UIStackView {

    @IBInspectable var starSize : CGSize = CGSize(width: 50.0, height: 50.0){
        didSet{
            setUpButton()
            updateButtonRating()
        }
    }
    @IBInspectable var starCount : Int = 5{
        didSet{
            setUpButton()
            updateButtonRating()
        }
    }
    @IBInspectable var rating : Int =  3{
        didSet{
            updateButtonRating()
        }
    }
    
    var ratingButtons = [UIButton]()
    
    override init(frame : CGRect){
        super.init(frame: frame)
        setUpButton()
        updateButtonRating()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpButton()
        updateButtonRating()
    }
    
    private func setUpButton() {
        
        removeExistingButton()
        for _ in 0..<starCount {
            let button = UIButton()
            button.setImage(UIImage(systemName: "star.fill"), for: .selected)
            button.setImage(UIImage(systemName: "star"), for: .normal)
            //No need to contraint in StackView. So we need to close contraint
            button.translatesAutoresizingMaskIntoConstraints = false
            //Set width and height of the button
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            addArrangedSubview(button)
            button.isUserInteractionEnabled = false
            
            ratingButtons.append(button)
        }
      
    }
    
    private func updateButtonRating() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
    
    private func removeExistingButton() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
    }
}
