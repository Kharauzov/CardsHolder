//
//  GradientView.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 14.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    @IBInspectable open dynamic var firstColor: UIColor = UIColor.white {
        didSet {
            updateColors()
        }
    }
    @IBInspectable open dynamic var secondColor: UIColor = UIColor.black {
        didSet {
            updateColors()
        }
    }
    @IBInspectable var startLocation: Double = 0 {
        didSet {
            updateLocations()
        }
    }
    @IBInspectable var endLocation: Double = 1 {
        didSet {
            updateLocations()
        }
    }
    @IBInspectable var horizontalMode: Bool = false {
        didSet {
            updatePoints()
        }
    }
    @IBInspectable var diagonalMode: Bool = false {
        didSet {
            updatePoints()
        }
    }
    
    private var gradientLayer: CAGradientLayer? {
        return layer.sublayers?.filter({$0 is CAGradientLayer}).first as? CAGradientLayer
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialise()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = bounds
        updatePoints()
        updateLocations()
        updateColors()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialise()
    }
    
    private func initialise() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func updatePoints() {
        if horizontalMode {
            gradientLayer?.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer?.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer?.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer?.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }
    
    private func updateLocations() {
        gradientLayer?.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    
    private func updateColors() {
        gradientLayer?.colors = [firstColor.cgColor, secondColor.cgColor]
    }
}
