//
//  ProfileShortInfoAnimationHandler.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 06.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

struct ProfileShortInfoAnimationHandler {
    
    let avatarImageView: UIImageView
    let cardView: UIView
    let globalView: UIView
    var avatarSnapshotView: UIView?
    let distance: CGFloat = 10
    let statusBarHeight: CGFloat = 44
    
    private var avatarImageViewRelativeFrame: CGRect {
        return globalView.convert(avatarImageView.frame, from: avatarImageView.superview)
    }
    
    init(globalView: UIView, avatarImageView: UIImageView, cardView: UIView) {
        self.globalView = globalView
        self.avatarImageView = avatarImageView
        self.cardView = cardView
        
        guard let snapshot = avatarImageView.snapshotView(afterScreenUpdates: false) else {
            return
        }
        avatarSnapshotView = snapshot
        globalView.addSubview(snapshot)
        snapshot.frame = avatarImageViewRelativeFrame
        avatarImageView.alpha = 0
    }
    
    func handleFramesUpdate() {
        guard let avatarSnapshotView = avatarSnapshotView else { return }
        guard let cardViewFrame = cardView.layer.presentation()?.frame else { return }
        if cardViewFrame.origin.y <= avatarImageViewRelativeFrame.maxY + distance {
            let fullDistance = avatarImageView.frame.height + distance + statusBarHeight
            if cardViewFrame.origin.y <= fullDistance {
                let avatarSnapshotViewHeight = cardViewFrame.origin.y - distance - statusBarHeight
                avatarSnapshotView.frame.size = CGSize(width: avatarSnapshotViewHeight, height: avatarSnapshotViewHeight)
            }
            avatarSnapshotView.frame.origin.y = max(cardViewFrame.origin.y - distance - avatarSnapshotView.bounds.height, statusBarHeight)
            avatarSnapshotView.center.x = avatarImageView.center.x
        } else {
            avatarSnapshotView.frame = avatarImageViewRelativeFrame
        }
    }
}
