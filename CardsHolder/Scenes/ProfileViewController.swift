//
//  ProfileViewController.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 20.02.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class ProfileViewController: CardsHolderViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        didOccurDraggingEvent = { value in
            debugPrint("\(Date().description) Dragging value \(value)")
        }
        
        let topViewController = UIViewController()
        topViewController.view.backgroundColor = .yellow
        
        let card1ViewController = UIViewController()
        
        let card2ViewController = UIViewController()
        card2ViewController.view.backgroundColor = .green
        
        setTopChildViewController(topViewController)
        setCard1ChildViewController(card1ViewController)
        setCard2ChildViewController(card2ViewController)
    }
}
