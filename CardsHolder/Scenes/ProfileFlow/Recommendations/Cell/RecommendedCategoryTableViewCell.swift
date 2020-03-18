//
//  RecommendedCategoryTableViewCell.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 18.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class RecommendedCategoryTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var hostedView: UIView? {
        didSet {
            guard let hostedView = hostedView else {
                return
            }
            hostedView.frame = contentView.bounds
            contentView.addSubview(hostedView)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if hostedView?.superview == contentView { // Make sure that hostedView hasn't been added as a subview to a different cell
            hostedView?.removeFromSuperview()
        }
        hostedView = nil
    }
}
