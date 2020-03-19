//
//  CardsHolderView.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 19.02.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

extension CardsHolderView {
    struct Constants {
        static let closedCardViewHeight: CGFloat = 80
        static let cardTopCornerRadius: CGFloat = 34
        /// We need to use overlay effect for all subviews in the hierarchy
        /// due to round corners. http://snpy.in/XVxLbD
        static let subviewBottomOffset: CGFloat = 40
        static let minCardTopMargin: CGFloat = 88
        static let shortAnimationDuration: TimeInterval = 0.33
        static let mediumAnimationDuration: TimeInterval = 1
        static let topPositionCardsInterval: CGFloat = 20
        static let draggingThreshold: CGFloat = 50
        static let cardsSpringWithDamping: CGFloat = 1
        static let card1InitialVerticalOffset: CGFloat = 74
    }
}

class CardsHolderView: UIView {

    // MARK: Properties
    
    let topView: UIView = {
        let view = UIView()
        return view
    }()
    let cardView1: CardView = {
        let view = CardView()
        return view
    }()
    let cardView2: CardView = {
        let view = CardView()
        return view
    }()
    
    // MARK: Public methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialise()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func initialise() {
        addSubviews()
    }
    
    private func addSubviews() {
        addSubview(topView)
        addSubview(cardView1)
        addSubview(cardView2)
        let screenBounds = UIScreen.main.bounds
        // setting card #2
        cardView2.frame = CGRect(x: 0, y: screenBounds.maxY - Constants.closedCardViewHeight, width: screenBounds.width, height: screenBounds.maxY - Constants.minCardTopMargin)
        // setting card #1
        cardView1.frame = CGRect(x: 0, y: cardView2.frame.minY - Constants.card1InitialVerticalOffset, width: screenBounds.width, height: screenBounds.maxY - Constants.minCardTopMargin)
        // setting top container
        topView.frame = CGRect(x: 0, y: 0, width: screenBounds.width, height: cardView1.frame.minY + Constants.subviewBottomOffset)
        // perform roundings
        cardView1.roundCorners(top: true, cornerRadii: Constants.cardTopCornerRadius)
        cardView2.roundCorners(top: true, cornerRadii: Constants.cardTopCornerRadius)        
    }
}
