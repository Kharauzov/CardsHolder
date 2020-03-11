//
//  RecommendationsView.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 11.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class RecommendationsView: UIView {

    let dragIndicatorView: DragIndicatorView = {
        let view = DragIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let titleLabel: CardTitleLabel = {
        let label = CardTitleLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialise()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialise() {
        backgroundColor = .white
        addSubviews()
    }

    private func addSubviews() {
        addSubview(dragIndicatorView)
        NSLayoutConstraint(item: dragIndicatorView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 6).isActive = true
        NSLayoutConstraint(item: dragIndicatorView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: dragIndicatorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 4).isActive = true
        NSLayoutConstraint(item: dragIndicatorView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 28).isActive = true
        addSubview(titleLabel)
        NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 30).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: GridLayout.regularSpace * 3).isActive = true
    }

}
