//
//  UIFont+Extension.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 14.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    /// Custom font family of the app is `Montserrat`.
    static func customFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        if weight == .bold {
            return UIFont(name: "Montserrat-Bold", size: fontSize)!
        } else if weight == .medium {
            return UIFont(name: "Montserrat-Medium", size: fontSize)!
        }
        return UIFont(name: "Montserrat-Regular", size: fontSize)! // as default font
    }
}

