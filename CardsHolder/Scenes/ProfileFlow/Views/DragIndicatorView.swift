//
//  DragIndicatorView.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 11.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class DragIndicatorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        backgroundColor = UIColor.AppColors.indicator.withAlphaComponent(0.5)
        alpha = 0.3
        layer.cornerRadius = 2.5
    }
}
