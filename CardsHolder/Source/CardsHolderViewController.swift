//
//  CardsHolderViewController.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 19.02.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class CardsHolderViewController: UIViewController {

    // MARK: Properties
    
    lazy var customView = view as! CardsHolderView
    
    // MARK: Lifecycle

    override func loadView() {
        view = CardsHolderView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
