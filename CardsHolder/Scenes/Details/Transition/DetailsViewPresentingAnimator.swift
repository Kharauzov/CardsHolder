//
//  DetailsViewPresentingAnimator.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 14.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class DetailsViewPresentingAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let originImageFrame: CGRect
    let imageView: UIImageView
    
    init(originImageFrame: CGRect, imageView: UIImageView) {
        self.originImageFrame = originImageFrame
        self.imageView = imageView
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedView = transitionContext.view(forKey: .to) as? DetailsView else {
            return
        }
        guard let presentingView = transitionContext.viewController(forKey: .from)?.view else {
            return
        }
        imageView.isHidden = true
        presentedView.layoutIfNeeded()
        presentedView.imageContainerView.transform = CGAffineTransform(translationX: 0, y: -presentedView.imageContainerView.frame.height)
        presentedView.bottomContainerView.transform = CGAffineTransform(translationX: 0, y: presentedView.bottomContainerView.frame.height)
        presentedView.backgroundView.alpha = 0
        presentedView.dismissButton.alpha = 0
        presentedView.imageView.isHidden = true
        
        let imageViewSnapshot = UIImageView(image: imageView.image)
        imageViewSnapshot.contentMode = imageView.contentMode
        imageViewSnapshot.layer.cornerRadius = imageView.layer.cornerRadius
        imageViewSnapshot.frame = originImageFrame
        imageViewSnapshot.clipsToBounds = true

        let imageShadowView = UIView()
        imageShadowView.frame = originImageFrame
        imageShadowView.frame.origin.y = originImageFrame.origin.y + 10
        imageShadowView.frame.size.height = originImageFrame.height - 30
        imageShadowView.addSketchShadow(color: .black, alpha: 0.22, x: 5, y: 0, blur: 12, spread: 4)
        
        transitionContext.containerView.addSubview(presentedView)
        presentedView.insertSubview(imageShadowView, belowSubview: presentedView.bottomContainerView)
        presentedView.insertSubview(imageViewSnapshot, belowSubview: presentedView.bottomContainerView)
        
        presentedView.frame = presentingView.frame
        presentedView.layoutIfNeeded()
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration / 2, delay: 0, options: .curveEaseInOut, animations: {
            presentedView.backgroundView.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            presentedView.dismissButton.alpha = 1
            imageViewSnapshot.frame = presentedView.imageView.frame
            presentedView.bottomContainerView.transform = .identity
            presentedView.imageContainerView.transform = .identity
        }, completion: { _ in
            imageViewSnapshot.removeFromSuperview()
            presentedView.imageShadowView = imageShadowView
            presentedView.imageContainerView.insertSubview(imageShadowView, belowSubview: presentedView.imageView)
            presentedView.imageView.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        
        let imageShadowViewNewFrame = CGRect(x: presentedView.imageView.frame.origin.x,
                                             y: presentedView.imageView.frame.origin.y + 30,
                                             width: presentedView.imageView.frame.size.width,
                                             height: presentedView.imageView.frame.size.height - 30)
        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.fromValue = imageShadowView.layer.position
        positionAnimation.toValue = CGPoint(x: imageShadowViewNewFrame.midX, y: imageShadowViewNewFrame.midY)
        let boundsAnimation = CABasicAnimation(keyPath: "bounds")
        boundsAnimation.fromValue = imageShadowView.layer.bounds
        boundsAnimation.toValue = CGRect(origin: .zero, size: imageShadowViewNewFrame.size)
        imageShadowView.layer.frame = imageShadowViewNewFrame
        let shadowAnimation = CABasicAnimation(keyPath: "shadowPath")
        shadowAnimation.fromValue = imageShadowView.layer.shadowPath
        shadowAnimation.toValue = UIBezierPath(rect: imageShadowView.bounds).cgPath
        imageShadowView.layer.shadowPath = UIBezierPath(rect: imageShadowView.bounds).cgPath
        let group = CAAnimationGroup()
        group.duration = duration
        group.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        group.animations = [positionAnimation, boundsAnimation, shadowAnimation]
        imageShadowView.layer.add(group, forKey: "animations")
    }
}
