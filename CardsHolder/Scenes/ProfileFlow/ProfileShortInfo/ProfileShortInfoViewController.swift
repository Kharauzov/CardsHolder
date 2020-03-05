//
//  ProfileShortInfoViewController.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 05.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class ProfileShortInfoViewController: UIViewController {

    lazy var customView = view as! ProfileShortInfoView
    
    override func loadView() {
        view = ProfileShortInfoView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.avatarImageView.image = #imageLiteral(resourceName: "avatar")
        customView.profileRankLabel.text = "Reader"
        customView.titleLabel.text = "Isabel Klein"
    }
}
