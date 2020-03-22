//
//  ProfileShortInfoAnimationHandler.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 06.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

struct ProfileShortInfoAnimationHandler {
    
    let cardView: UIView
    let globalView: UIView
    let profileShortInfoView: ProfileShortInfoView
    var avatarSnapshotView: UIView?
    
    
    let minAvatarHeight: CGFloat = 35
    let topMargin: CGFloat = CardsHolderView.Constants.minCardTopMargin / 2
    let initialCardViewFrame: CGRect
    
    private var avatarImageViewRelativeFrame: CGRect {
        return globalView.convert(profileShortInfoView.avatarImageView.frame, from: profileShortInfoView.avatarImageView.superview)
    }
    
    init(globalView: UIView, cardView: UIView, profileShortInfoView: ProfileShortInfoView) {
        self.profileShortInfoView = profileShortInfoView
        self.globalView = globalView
        self.cardView = cardView
        self.initialCardViewFrame = cardView.frame
        guard let snapshot = profileShortInfoView.avatarImageView.snapshotView(afterScreenUpdates: false) else {
            return
        }
        avatarSnapshotView = snapshot
        globalView.addSubview(snapshot)
        snapshot.frame = avatarImageViewRelativeFrame
        profileShortInfoView.avatarImageView.alpha = 0
    }
    
    func handleFramesUpdate() {
        guard let avatarSnapshotView = avatarSnapshotView else { return }
        guard let cardViewFrame = cardView.layer.presentation()?.frame else { return }
        let fullDraggingDistance = initialCardViewFrame.origin.y - CardsHolderView.Constants.minCardTopMargin
        let draggedDistance = initialCardViewFrame.origin.y - cardViewFrame.origin.y
        let progress = ((fullDraggingDistance - draggedDistance) / fullDraggingDistance)
        let avatarTotalHeightDelta = avatarImageViewRelativeFrame.size.height - minAvatarHeight
        let avatarSnapshotViewHeight = max((avatarTotalHeightDelta * progress) + minAvatarHeight, minAvatarHeight)
        avatarSnapshotView.frame.size = CGSize(width: avatarSnapshotViewHeight, height: avatarSnapshotViewHeight)
        
        let avatarTotalYDelta = avatarImageViewRelativeFrame.origin.y - topMargin
        let avatarY = max((avatarTotalYDelta * progress) + topMargin, topMargin)
        avatarSnapshotView.frame.origin.y = avatarY
        avatarSnapshotView.center.x = profileShortInfoView.avatarImageView.center.x
        
        if avatarSnapshotView.frame.origin.y > avatarImageViewRelativeFrame.origin.y {
            avatarSnapshotView.frame = avatarImageViewRelativeFrame
        }
        let translationTitleLabelY = 200 * (1 - progress) * -1
        let translationRankViewLabelY = 180 * (1 - progress) * -1
        profileShortInfoView.titleLabel.transform = CGAffineTransform(translationX: 0, y: translationTitleLabelY)
        profileShortInfoView.profileRankContainerView.transform = CGAffineTransform(translationX: 0, y: translationRankViewLabelY)
        let viewsAlpha = pow(progress, CGFloat(2))
        profileShortInfoView.titleLabel.alpha = viewsAlpha
        profileShortInfoView.profileRankContainerView.alpha = viewsAlpha
    }
}
