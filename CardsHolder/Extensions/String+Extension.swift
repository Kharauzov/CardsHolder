//
//  String+Extension.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 14.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

extension String {
    func formattedString(font: UIFont, textColor: UIColor, lineHeight: CGFloat?, letterSpace: CGFloat, alignment: NSTextAlignment) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        if let lineHeight = lineHeight {
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.maximumLineHeight = lineHeight
        }
        paragraphStyle.alignment = alignment
        let attrString = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: attrString.length)
        attrString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        attrString.addAttribute(NSAttributedString.Key.kern, value: letterSpace, range: range)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: range)
        return attrString
    }
}
