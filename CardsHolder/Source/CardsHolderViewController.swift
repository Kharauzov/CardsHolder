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
        _ = cardsDragger
    }
    
    // MARK: Private methods
    
    private func add(_ child: UIViewController, shouldAddView: Bool = false) {
        addChild(child)
        if shouldAddView {
            view.addSubview(child.view)
        }
        child.didMove(toParent: self)
    }
    
    private func remove(_ child: UIViewController, shouldRemoveView: Bool = false) {
        guard child.parent != nil else {
            return
        }
        child.willMove(toParent: nil)
        if shouldRemoveView {
            child.view.removeFromSuperview()
        }
        child.removeFromParent()
    }
    
    private func setCardChildViewController(_ viewController: UIViewController, hostView: CardView) {
        add(viewController)
        hostView.addSubview(viewController.view)
        hostView.backgroundColor = viewController.view.backgroundColor
        viewController.view.frame = CGRect(origin: hostView.bounds.origin, size: CGSize(width: hostView.bounds.size.width, height: hostView.bounds.size.height - CardsHolderView.Constants.subviewBottomOffset))
    }
    
    // MARK: Public methods
    
    final func setTopChildViewController(_ viewController: UIViewController) {
        add(viewController)
        customView.topView.addSubview(viewController.view)
        let origin = CGPoint(x: 0, y: CardsHolderView.Constants.navigationBarHeight)
        let size = CGSize(width: customView.topView.frame.size.width, height: customView.topView.frame.size.height - CardsHolderView.Constants.subviewBottomOffset - CardsHolderView.Constants.navigationBarHeight)
        viewController.view.frame = CGRect(origin: origin, size: size)
    }

    final func setCard1ChildViewController(_ viewController: UIViewController) {
        setCardChildViewController(viewController, hostView: customView.cardView1)
    }
    
    final func setCard2ChildViewController(_ viewController: UIViewController) {
        setCardChildViewController(viewController, hostView: customView.cardView2)
    }

    final func openTopCard(animated: Bool) {
        cardsDragger.openTopCard(animated: animated)
    }
    
    final func closeTopCard(animated: Bool) {
        cardsDragger.closeTopCard(animated: animated)
    }
    
    final func openBottomCard(animated: Bool) {
        cardsDragger.openBottomCard(animated: animated)
    }
    
    final func closeBottomCard(animated: Bool) {
        cardsDragger.closeBottomCard(animated: animated)
    }
}
