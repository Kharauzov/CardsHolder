//
//  ProgressView.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 05.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class ProgressView: UIView {

    let highlightView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#69CA87")
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var widthConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialise()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialise() {
        backgroundColor = UIColor(hexString: "#E9E9E9")
        layer.cornerRadius = 3
        addSubview(highlightView)
        NSLayoutConstraint(item: highlightView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: highlightView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: highlightView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        widthConstraint = NSLayoutConstraint(item: highlightView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
        widthConstraint?.isActive = true
    }
    
    func update(progress: CGFloat) {
        layoutIfNeeded()
        widthConstraint?.constant = bounds.width * progress
    }
}
