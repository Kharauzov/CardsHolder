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
        static let closedCardViewHeight: CGFloat = 120
        static let cardTopCornerRadius: CGFloat = 34
        /// We need to use overlay effect for all subviews in the hierarchy
        /// due to round corners. http://snpy.in/XVxLbD
        static let subviewBottomOffset: CGFloat = 30
        static let navigationBarHeight: CGFloat = 88
    }
}

class CardsHolderView: UIView {

    // MARK: Properties
    
    private let topContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#5F2DA0")
        return view
    }()
    private let cardContainerView1: CardView = {
        let view = CardView()
        view.backgroundColor = UIColor(hexString: "#FCAA43")
        return view
    }()
    private let cardContainerView2: CardView = {
        let view = CardView()
        view.backgroundColor = UIColor(hexString: "#000000")
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
        addSubview(topContainerView)
        addSubview(cardContainerView1)
        addSubview(cardContainerView2)
        let screenBounds = UIScreen.main.bounds
        // setting card #2
        cardContainerView2.frame = CGRect(x: 0, y: screenBounds.maxY - Constants.closedCardViewHeight, width: screenBounds.width, height: Constants.closedCardViewHeight)
        // setting card #1
        cardContainerView1.frame = cardContainerView2.frame
        cardContainerView1.frame.origin.y = cardContainerView2.frame.minY - (Constants.closedCardViewHeight - Constants.subviewBottomOffset)
        // setting top container
        topContainerView.frame = CGRect(x: 0, y: 0, width: screenBounds.width, height: cardContainerView1.frame.minY + Constants.subviewBottomOffset)
        // perform roundings
        cardContainerView1.roundCorners(top: true, cornerRadii: Constants.cardTopCornerRadius)
        cardContainerView2.roundCorners(top: true, cornerRadii: Constants.cardTopCornerRadius)
    }
}
