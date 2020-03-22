//
//  UIColor+Extension.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 20.02.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    struct AppColors {
        static let black = UIColor(hexString: "#060518")
        static let blackSecondary = UIColor(hexString: "#1F232A")
        static let indicator = UIColor(hexString: "#010101")
        static let titleDark = UIColor(hexString: "#0C0C0C")
        static let grey = UIColor(hexString: "#656464")
        static let green = UIColor(hexString: "#69CA87")
        static let lightGrey = UIColor(hexString: "#E9E9E9")
        static let yellow = UIColor(hexString: "#FFCE32")
    }
    
    /**
     Creates an UIColor from **"#ffffff"** format
     - parameter hexString: **String** like **"#ffffff"**
     - returns: UIColor from HexString
     */
    convenience init(hexString: String) {
        
        let hexString: String = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString as String)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
}
