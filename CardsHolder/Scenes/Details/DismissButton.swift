//
//  DismissButton.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 18.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit


class DismissButton: UIButton {
    
    var extraTapPadding: CGFloat = 0
    
    /// Overrides method in order to increase
    /// interaction(tappable) area of the UIControl.
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if extraTapPadding != 0 {
            let biggerFrame = bounds.insetBy(dx: -extraTapPadding, dy: -extraTapPadding)
            return biggerFrame.contains(point)
        }
        return bounds.contains(point)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialise()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialise() {
        tintColor = .white
        setImage(#imageLiteral(resourceName: "back"), for: .normal)
    }
}
