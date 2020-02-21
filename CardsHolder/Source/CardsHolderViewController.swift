//
//  CardsHolderViewController.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 19.02.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class CardsHolderViewController: UIViewController {

    // MARK: Public properties
    
    var didOccurDraggingEvent: ((_ value: CGFloat) -> Void)? {
        willSet {
            cardsDragger.didOccurDraggingEvent = newValue
        }
    }
    
    // MARK: Private Properties
    
    private lazy var customView = view as! CardsHolderView
    private lazy var cardsDragger = CardsDragger(view: self.customView, cardView1: self.customView.cardView1, cardView2: self.customView.cardView2)
    
    // MARK: Lifecycle

    override func loadView() {
        view = CardsHolderView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundColors()
        _ = cardsDragger
    }
    
    // FIXME: remove this after testing
    private func setupBackgroundColors() {
        customView.topView.backgroundColor = UIColor(hexString: "#5F2DA0")
        customView.cardView1.backgroundColor = UIColor(hexString: "#FCAA43")
        customView.cardView2.backgroundColor = UIColor(hexString: "#000000")
    }
    
    // MARK: Public methods
    
    func openTopCard(animated: Bool) {
        cardsDragger.openTopCard(animated: animated)
    }
    
    func closeTopCard(animated: Bool) {
        cardsDragger.closeTopCard(animated: animated)
    }
    
    func openBottomCard(animated: Bool) {
        cardsDragger.openBottomCard(animated: animated)
    }
    
    func closeBottomCard(animated: Bool) {
        cardsDragger.closeBottomCard(animated: animated)
    }
}
