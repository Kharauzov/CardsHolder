//
//  CardTitleLabel.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 11.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class CardTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialise()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialise() {
        textColor = UIColor(hexString: "#0C0C0C")
        font = .customFont(ofSize: 20, weight: .bold)
        textAlignment = .left
    }
}
