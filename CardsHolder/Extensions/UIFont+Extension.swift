//
//  UIFont+Extension.swift
//  Otrium
//
//  Created by Serhii Kharauzov on 4/4/19.
//  Copyright © 2019 Otrium. All rights reserved.
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

