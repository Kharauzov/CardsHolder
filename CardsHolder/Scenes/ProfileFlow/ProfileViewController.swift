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
    var detailsViewPresentingAnimator: DetailsViewPresentingAnimator?
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didOccurDraggingEvent = { [weak self] value in
            self?.animationHandler?.handleFramesUpdate()
        }
        setChildViewControllers()
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
        openTopCard(animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func showDetailsView(selectedModel: ProfileActivitySelectedViewModel, activityView: UIView) {
        let imageRelativeFrame = view.convert(selectedModel.imageViewParentRelativeFrame, from: activityView)
        detailsViewPresentingAnimator = DetailsViewPresentingAnimator(originImageFrame: imageRelativeFrame, imageView: selectedModel.imageView)
        let viewController = DetailsViewController(viewModel: selectedModel.item)
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
        present(viewController, animated: true, completion: nil)
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
        
        card1ViewController.didSelectItem = { [unowned self] selectedModel in
            self.showDetailsView(selectedModel: selectedModel, activityView: card1ViewController.view)
        }
    }
}

// MARK: UIViewControllerTransitioning Delegate

extension ProfileViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return detailsViewPresentingAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DetailsViewDismissingAnimator()
    }
}
