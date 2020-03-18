//
//  RatingView.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 18.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class RatingView: UIView {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.axis = .horizontal
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialise()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRating(_ value: Int) {
        stackView.arrangedSubviews.forEach { (view) in
            if let imageView = view as? UIImageView {
                imageView.image = imageView.tag > value ? #imageLiteral(resourceName: "unselectedStar") : #imageLiteral(resourceName: "selectedStar")
            }
        }
    }
    
    private func initialise() {
        addSubview(stackView)
        NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        
        for index in 1 ... 5 {
            let imageView = UIImageView(image: #imageLiteral(resourceName: "unselectedStar"))
            imageView.contentMode = .scaleAspectFit
            imageView.tag = index
            stackView.addArrangedSubview(imageView)
        }
    }

}
