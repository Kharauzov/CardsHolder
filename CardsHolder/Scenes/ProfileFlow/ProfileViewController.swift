//
//  ProfileViewController.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 20.02.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class ProfileViewController: CardsHolderViewController {

    // MARK: Properties
    
    var animationHandler: ProfileShortInfoAnimationHandler?
    var topViewController: ProfileShortInfoViewController?
    var activityViewController: ProfileActivityViewController?
    var recommendationsViewController: RecommendationsViewController?
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didOccurDraggingEvent = { [weak self] value in
            //debugPrint("\(Date().description) Dragging value \(value)")
            self?.animationHandler?.handleFramesUpdate()
        }
        setChildViewControllers()
    }
    
    private func setChildViewControllers() {
        let topViewController = ProfileShortInfoViewController()
        view.backgroundColor = topViewController.view.backgroundColor
        let card1ViewController = ProfileActivityViewController()
        let card2ViewController = RecommendationsViewController()
        setTopChildViewController(topViewController)
        setCard1ChildViewController(card1ViewController)
        setCard2ChildViewController(card2ViewController)
        self.topViewController = topViewController
        self.activityViewController = card1ViewController
        self.recommendationsViewController = card2ViewController
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if animationHandler == nil {
            guard let profileShortInfoView = topViewController?.customView,
                let cardView1 = activityViewController?.view.superview
                else {
                return
            }
            animationHandler = ProfileShortInfoAnimationHandler(globalView: view, cardView: cardView1, profileShortInfoView: profileShortInfoView)
        }
    }
}
