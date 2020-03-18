//
//  DetailsViewDismissingAnimator.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 14.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class DetailsViewDismissingAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let originImageFrame: CGRect
    let imageView: UIImageView
    
    init(originImageFrame: CGRect, imageView: UIImageView) {
        self.originImageFrame = originImageFrame
        self.imageView = imageView
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedView = transitionContext.view(forKey: .from) as? DetailsView else {
            return
        }
        guard let imageShadowView = presentedView.imageShadowView else {
            return
        }
        presentedView.imageView.isHidden = true
        let imageViewSnapshot = UIImageView(image: presentedView.imageView.image)
        imageViewSnapshot.contentMode = imageView.contentMode
        imageViewSnapshot.layer.cornerRadius = imageView.layer.cornerRadius
        imageViewSnapshot.frame = presentedView.imageView.frame
        imageViewSnapshot.clipsToBounds = true
        
        presentedView.insertSubview(imageShadowView, belowSubview: presentedView.bottomContainerView)
        presentedView.insertSubview(imageViewSnapshot, belowSubview: presentedView.bottomContainerView)
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration / 2, delay: 0, options: .curveEaseInOut, animations: {
            presentedView.backgroundView.alpha = 0
        }, completion: nil)
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            presentedView.dismissButton.alpha = 0
            imageViewSnapshot.frame = self.originImageFrame
            imageShadowView.alpha = 0
            presentedView.imageContainerView.transform = CGAffineTransform(translationX: 0, y: -presentedView.imageContainerView.frame.height)
            presentedView.bottomContainerView.transform = CGAffineTransform(translationX: 0, y: presentedView.bottomContainerView.frame.height)
        }, completion: { _ in
            imageViewSnapshot.removeFromSuperview()
            self.imageView.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        
        let imageShadowViewNewFrame = CGRect(x: originImageFrame.origin.x,
                                             y: originImageFrame.origin.y + 30,
                                             width: originImageFrame.size.width,
                                             height: originImageFrame.size.height - 30)
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
