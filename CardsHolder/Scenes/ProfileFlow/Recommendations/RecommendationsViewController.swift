//
//  RecommendationsViewController.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 05.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class RecommendationsViewController: UIViewController {

    lazy var customView = view as! RecommendationsView
    
    override func loadView() {
        view = RecommendationsView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.titleLabel.text = "Recommended"
    }
}
