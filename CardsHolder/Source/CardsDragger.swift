//
//  CardsDragger.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 21.02.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class CardsDragger: NSObject {
    
    // MARK: Private properties
    
    /// Gesture for cardContainerView1
    private lazy var panGestureRecognizer1 = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizer1Occur))
    /// Gesture for cardContainerView1
    private lazy var panGestureRecognizer2 = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizer2Occur))
    private var initialCard1Frame: CGRect = .zero
    private var initialCard2Frame: CGRect = .zero
    private var beginDraggingFrame: CGRect = .zero
    private var beginDraggingSecondaryFrame: CGRect = .zero
    private var displayLink: CADisplayLink?
    private var areBothCardsOpened: Bool {
        return cardView1.state == .open && cardView2.state == .open
    }
    
    // MARK: Public properties
    
    let view: UIView
    let cardView1: CardView
    let cardView2: CardView
    var didOccurDraggingEvent: ((_ value: CGFloat) -> Void)?
    private var cardView1FrameObservation: NSKeyValueObservation?
    private var cardView2FrameObservation: NSKeyValueObservation?
    
    init(view: UIView, cardView1: CardView, cardView2: CardView) {
        self.view = view
        self.cardView1 = cardView1
        self.cardView2 = cardView2
        super.init()
        initialise()
    }
    
    deinit {
        invalidateDisplayLink()
    }
    
    // MARK: Private methods
    
    private func initialise() {
        setInitialCardsFrames()
        setupGestureRecognizer()
    }
    
    private func setInitialCardsFrames() {
        initialCard1Frame = cardView1.frame
        initialCard2Frame = cardView2.frame
    }
    
    private func setupGestureRecognizer() {
        cardView1.addGestureRecognizer(panGestureRecognizer1)
        cardView2.addGestureRecognizer(panGestureRecognizer2)
    }
    
    private func cardDraggingOccured(cardView1Frame: CGRect, cardView2Frame: CGRect) {
        let fullDistance = initialCard1Frame.origin.y - CardsHolderView.Constants.navigationBarHeight
        let currentDistance = cardView1Frame.origin.y - CardsHolderView.Constants.navigationBarHeight
        let value = (fullDistance - currentDistance) / fullDistance
        didOccurDraggingEvent?(value)
    }
    
    @objc private func panGestureRecognizer1Occur(_ sender: UIPanGestureRecognizer) {
        if areBothCardsOpened { return }
        guard let cardContainerView = sender.view, cardContainerView == cardView1 else { return }
        let translation = sender.translation(in: view)
        let newY = cardView1.frame.origin.y + translation.y
        switch sender.state {
        case .began:
            beginDraggingFrame = cardView1.frame
        case .changed:
            if newY >= CardsHolderView.Constants.navigationBarHeight && newY <= initialCard1Frame.origin.y {
                cardView1.frame.origin.y = newY
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
                move(view: cardView1, toFrame: beginDraggingFrame, animated: true)
            }
            beginDraggingFrame = .zero
        default: break
        }
        cardDraggingOccured(cardView1Frame: cardView1.frame, cardView2Frame: cardView2.frame)
    }
    
    @objc private func panGestureRecognizer2Occur(_ sender: UIPanGestureRecognizer) {
        guard let cardContainerView = sender.view, cardContainerView == cardView2 else { return }
        let translation = sender.translation(in: view)
        let newY = cardView2.frame.origin.y + translation.y
        switch sender.state {
        case .began:
            beginDraggingFrame = cardView2.frame
            beginDraggingSecondaryFrame = cardView1.frame
        case .changed:
            if newY >= CardsHolderView.Constants.navigationBarHeight + CardsHolderView.Constants.topPositionCardsInterval && newY <= initialCard2Frame.origin.y {
                cardView2.frame.origin.y = newY
                let isMinIntervalReached = newY <= cardView1.frame.origin.y + CardsHolderView.Constants.topPositionCardsInterval
                let isCardView1YLowerItsMinValue = cardView1.frame.origin.y <= initialCard1Frame.origin.y
                if ((isMinIntervalReached || isCardView1YLowerItsMinValue) && cardView1.state != .open)
                    || areBothCardsOpened {
                    let cardView1NewY = CGFloat.minimum(newY - CardsHolderView.Constants.topPositionCardsInterval, initialCard1Frame.origin.y)
                    cardView1.frame.origin.y = cardView1NewY
                }
            }
            sender.setTranslation(CGPoint.zero, in: view)
        case .ended, .failed, .cancelled:
            let draggingDistance = newY - beginDraggingFrame.origin.y
            if abs(draggingDistance) > CardsHolderView.Constants.draggingThreshold {
                if draggingDistance < 0 {
                    openTopCard(animated: true)
                    openBottomCard(animated: true)
                } else {
                    closeTopCard(animated: true)
                    closeBottomCard(animated: true)
                }
            } else {
                move(view: cardView1, toFrame: beginDraggingSecondaryFrame, animated: true)
                move(view: cardView2, toFrame: beginDraggingFrame, animated: true)
            }
            beginDraggingFrame = .zero
            beginDraggingSecondaryFrame = .zero
        default: break
        }
        cardDraggingOccured(cardView1Frame: cardView1.frame, cardView2Frame: cardView2.frame)
    }
    
    private func move(view: UIView, toFrame: CGRect, animated: Bool) {
        addDisplayLink()
        UIView.animate(withDuration: CardsHolderView.Constants.shortAnimationDuration, delay: 0, options: .curveEaseOut, animations: {
            view.frame = toFrame
        }, completion: { (_) in
            self.invalidateDisplayLink()
        })
    }
    
    private func addDisplayLink() {
        if displayLink != nil { return }
        let displayLink = CADisplayLink(target: self, selector: #selector(animationDidUpdate))
        displayLink.preferredFramesPerSecond = 60
        
        displayLink.add(to: .current, forMode: .common)
        self.displayLink = displayLink
    }
    
    private func invalidateDisplayLink() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc private func animationDidUpdate() {
        guard let cardView1Frame = cardView1.layer.presentation()?.frame,
            let cardView2Frame = cardView2.layer.presentation()?.frame else {
                return
        }
        cardDraggingOccured(cardView1Frame: cardView1Frame, cardView2Frame: cardView2Frame)
    }
    
    // MARK: Public methods
    
    func openTopCard(animated: Bool) {
        addDisplayLink()
        cardView1.state = .open
        UIView.animate(withDuration: CardsHolderView.Constants.mediumAnimationDuration, delay: 0, usingSpringWithDamping: CardsHolderView.Constants.cardsSpringWithDamping, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.cardView1.frame.origin.y = CardsHolderView.Constants.navigationBarHeight
        }) { (_) in
            self.invalidateDisplayLink()
        }
    }
    
    func closeTopCard(animated: Bool) {
        addDisplayLink()
        cardView1.state = .closed
        UIView.animate(withDuration: CardsHolderView.Constants.mediumAnimationDuration, delay: 0, usingSpringWithDamping: CardsHolderView.Constants.cardsSpringWithDamping, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.cardView1.frame = self.initialCard1Frame
        }) { (_) in
            self.invalidateDisplayLink()
        }
    }
    
    func openBottomCard(animated: Bool) {
        addDisplayLink()
        cardView2.state = .open
        UIView.animate(withDuration: CardsHolderView.Constants.mediumAnimationDuration, delay: 0, usingSpringWithDamping: CardsHolderView.Constants.cardsSpringWithDamping, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.cardView2.frame.origin.y = CardsHolderView.Constants.navigationBarHeight + CardsHolderView.Constants.topPositionCardsInterval
        }) { (_) in
            self.invalidateDisplayLink()
        }
    }
    
    func closeBottomCard(animated: Bool) {
        addDisplayLink()
        cardView2.state = .closed
        UIView.animate(withDuration: CardsHolderView.Constants.mediumAnimationDuration, delay: 0, usingSpringWithDamping: CardsHolderView.Constants.cardsSpringWithDamping, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.cardView2.frame = self.initialCard2Frame
        }) { (_) in
            self.invalidateDisplayLink()
        }
    }
}
