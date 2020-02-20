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
    
    private lazy var customView = view as! CardsHolderView
    /// Gesture for cardContainerView1
    private lazy var panGestureRecognizer1 = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizer1Occur))
    /// Gesture for cardContainerView1
    private lazy var panGestureRecognizer2 = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizer2Occur))
    
    private var initialCard1Frame: CGRect = .zero
    private var initialCard2Frame: CGRect = .zero
    private var beginDraggingFrame: CGRect = .zero
    private var beginDraggingSecondaryFrame: CGRect = .zero
    
    // MARK: Lifecycle

    override func loadView() {
        view = CardsHolderView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundColors()
        setupGestureRecognizer()
        setInitialCardsFrames()
    }
    
    private func setInitialCardsFrames() {
        initialCard1Frame = customView.cardView1.frame
        initialCard2Frame = customView.cardView2.frame
    }
    
    private func setupBackgroundColors() {
        let topColor = UIColor(hexString: "#5F2DA0")
        customView.backgroundColor = topColor
        customView.topView.backgroundColor = topColor
        customView.cardView1.backgroundColor = UIColor(hexString: "#FCAA43")
        customView.cardView2.backgroundColor = UIColor(hexString: "#000000")
    }
    
    private func setupGestureRecognizer() {
        customView.cardView1.addGestureRecognizer(panGestureRecognizer1)
        customView.cardView2.addGestureRecognizer(panGestureRecognizer2)
    }
    
    @objc private func panGestureRecognizer1Occur(_ sender: UIPanGestureRecognizer) {
        guard let cardContainerView = sender.view else { return }
        let translation = sender.translation(in: view)
        let newY = cardContainerView.frame.origin.y + translation.y
        switch sender.state {
        case .began:
            beginDraggingFrame = cardContainerView.frame
        case .changed:
            if newY >= CardsHolderView.Constants.navigationBarHeight && newY <= initialCard1Frame.origin.y {
                cardContainerView.frame.origin.y = newY
            }
            sender.setTranslation(CGPoint.zero, in: view)
        case .ended, .failed, .cancelled:
            let draggingDistance = newY - beginDraggingFrame.origin.y
            if abs(draggingDistance) > CardsHolderView.Constants.draggingThreshold {
                if draggingDistance < 0 {
                    openTopCard(animated: true)
                } else {
                    closeTopCard(animated: true)
                }
            } else {
                debugPrint("\(beginDraggingFrame) beginDraggingFrame")
                move(view: cardContainerView, toFrame: beginDraggingFrame, animated: true)
            }
            beginDraggingFrame = .zero
        default: break
        }
    }
    
    @objc private func panGestureRecognizer2Occur(_ sender: UIPanGestureRecognizer) {
        guard let cardContainerView = sender.view else { return }
        let translation = sender.translation(in: view)
        let newY = cardContainerView.frame.origin.y + translation.y
        switch sender.state {
        case .began:
            beginDraggingFrame = cardContainerView.frame
            beginDraggingSecondaryFrame = customView.cardView1.frame
        case .changed:
            if newY >= CardsHolderView.Constants.navigationBarHeight + CardsHolderView.Constants.topPositionCardsInterval && newY <= initialCard2Frame.origin.y {
                cardContainerView.frame.origin.y = newY
                if newY <= initialCard1Frame.minY + CardsHolderView.Constants.topPositionCardsInterval {
                    customView.cardView1.frame.origin.y = newY - CardsHolderView.Constants.topPositionCardsInterval
                }
            }
            sender.setTranslation(CGPoint.zero, in: view)
        case .ended, .failed, .cancelled:
            let draggingDistance = newY - beginDraggingFrame.origin.y
            if abs(draggingDistance) > CardsHolderView.Constants.draggingThreshold {
                if draggingDistance < 0 {
                    openBottomCard(animated: true)
                } else {
                    closeBottomCard(animated: true)
                }
            } else {
                debugPrint("\(beginDraggingFrame) beginDraggingFrame")
                move(view: customView.cardView1, toFrame: beginDraggingSecondaryFrame, animated: true)
                move(view: cardContainerView, toFrame: beginDraggingFrame, animated: true)
            }
            beginDraggingFrame = .zero
            beginDraggingSecondaryFrame = .zero
        default: break
        }
    }
    
    private func move(view: UIView, toFrame: CGRect, animated: Bool) {
        UIView.animate(withDuration: CardsHolderView.Constants.shortAnimationDuration, delay: 0, options: .curveEaseOut, animations: {
            view.frame = toFrame
        }) { (_) in
            
        }
    }
    
    // MARK: Public methods
    
    func openTopCard(animated: Bool) {
        UIView.animate(withDuration: CardsHolderView.Constants.mediumAnimationDuration, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.customView.cardView1.frame.origin.y = CardsHolderView.Constants.navigationBarHeight
        }) { (_) in
            
        }
    }
    
    func closeTopCard(animated: Bool) {
        UIView.animate(withDuration: CardsHolderView.Constants.mediumAnimationDuration, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.customView.cardView1.frame = self.initialCard1Frame
        }) { (_) in
            
        }
    }
    
    func openBottomCard(animated: Bool) {
        UIView.animate(withDuration: CardsHolderView.Constants.mediumAnimationDuration, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.customView.cardView1.frame.origin.y = CardsHolderView.Constants.navigationBarHeight
            self.customView.cardView2.frame.origin.y = CardsHolderView.Constants.navigationBarHeight + CardsHolderView.Constants.topPositionCardsInterval
        }) { (_) in
            
        }
    }
    
    func closeBottomCard(animated: Bool) {
        UIView.animate(withDuration: CardsHolderView.Constants.mediumAnimationDuration, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.customView.cardView1.frame = self.initialCard1Frame
            self.customView.cardView2.frame = self.initialCard2Frame
        }) { (_) in
            
        }
    }
}
