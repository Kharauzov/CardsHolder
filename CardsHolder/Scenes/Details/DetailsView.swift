//
//  DetailsView.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 11.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class DetailsView: UIView {

    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let imageContainerView: GradientView = {
        let view = GradientView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var imageShadowView: UIView?
    let imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 9
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let bottomContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let actionButtonsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor.AppColors.black.withAlphaComponent(0.5)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textView.textColor = .black
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.lineFragmentPadding = 0
        textView.showsVerticalScrollIndicator = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    let dismissButton: DismissButton = {
        let button = DismissButton(type: UIButton.ButtonType.roundedRect)
        button.extraTapPadding = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "favourite"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let messageButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "message"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "share"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let bottomGradientView: GradientView = {
        let view = GradientView()
        view.firstColor = UIColor.white.withAlphaComponent(0)
        view.secondColor = UIColor.white
        view.horizontalMode = false
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialise()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialise() {
        backgroundColor = .clear
        addSubviews()
    }
    
    private func addSubviews() {
        addSubview(backgroundView)
        NSLayoutConstraint(item: backgroundView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: backgroundView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: backgroundView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: backgroundView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        
        addSubview(imageContainerView)
        NSLayoutConstraint(item: imageContainerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: imageContainerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: imageContainerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        
        imageContainerView.addSubview(imageView)
        NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: imageContainerView, attribute: .top, multiplier: 1.0, constant: GridLayout.regularSpace
         * 15).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: imageContainerView, attribute: .leading, multiplier: 1.0, constant: GridLayout.regularSpace
        * 8).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: imageContainerView, attribute: .trailing, multiplier: 1.0, constant: -GridLayout.regularSpace
        * 8).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 1.28, constant: 0).isActive = true
        
        addSubview(bottomContainerView)
        NSLayoutConstraint(item: bottomContainerView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.55, constant: 0).isActive = true
        NSLayoutConstraint(item: bottomContainerView, attribute: .top, relatedBy: .equal, toItem: imageContainerView, attribute: .bottom, multiplier: 1.0, constant: -200).isActive = true
        NSLayoutConstraint(item: bottomContainerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: bottomContainerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: bottomContainerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        
        bottomContainerView.addSubview(actionButtonsContainerView)
        NSLayoutConstraint(item: actionButtonsContainerView, attribute: .top, relatedBy: .equal, toItem: bottomContainerView, attribute: .top, multiplier: 1.0, constant: GridLayout.regularSpace * 3).isActive = true
        NSLayoutConstraint(item: actionButtonsContainerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44).isActive = true
        NSLayoutConstraint(item: actionButtonsContainerView, attribute: .leading, relatedBy: .equal, toItem: bottomContainerView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: actionButtonsContainerView, attribute: .trailing, relatedBy: .equal, toItem: bottomContainerView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        
        actionButtonsContainerView.addSubview(messageButton)
        NSLayoutConstraint(item: messageButton, attribute: .centerY, relatedBy: .equal, toItem: actionButtonsContainerView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: messageButton, attribute: .centerX, relatedBy: .equal, toItem: actionButtonsContainerView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: messageButton, attribute: .height, relatedBy: .equal, toItem: actionButtonsContainerView, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: messageButton, attribute: .width, relatedBy: .equal, toItem: messageButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        
        actionButtonsContainerView.addSubview(favoriteButton)
        NSLayoutConstraint(item: favoriteButton, attribute: .centerY, relatedBy: .equal, toItem: actionButtonsContainerView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: favoriteButton, attribute: .trailing, relatedBy: .equal, toItem: messageButton, attribute: .leading, multiplier: 1.0, constant: -GridLayout.regularSpace * 4).isActive = true
        NSLayoutConstraint(item: favoriteButton, attribute: .height, relatedBy: .equal, toItem: actionButtonsContainerView, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: favoriteButton, attribute: .width, relatedBy: .equal, toItem: favoriteButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        
        actionButtonsContainerView.addSubview(shareButton)
        NSLayoutConstraint(item: shareButton, attribute: .centerY, relatedBy: .equal, toItem: actionButtonsContainerView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: shareButton, attribute: .leading, relatedBy: .equal, toItem: messageButton, attribute: .trailing, multiplier: 1.0, constant: GridLayout.regularSpace * 4).isActive = true
        NSLayoutConstraint(item: shareButton, attribute: .height, relatedBy: .equal, toItem: actionButtonsContainerView, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: shareButton, attribute: .width, relatedBy: .equal, toItem: shareButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        
        bottomContainerView.addSubview(titleLabel)
        NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: actionButtonsContainerView, attribute: .bottom, multiplier: 1.0, constant: GridLayout.regularSpace * 4).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: bottomContainerView, attribute: .leading, multiplier: 1.0, constant: GridLayout.regularSpace * 4).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: bottomContainerView, attribute: .trailing, multiplier: 1.0, constant: -GridLayout.regularSpace * 4).isActive = true
        
        bottomContainerView.addSubview(authorLabel)
        NSLayoutConstraint(item: authorLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: GridLayout.regularSpace).isActive = true
        NSLayoutConstraint(item: authorLabel, attribute: .centerX, relatedBy: .equal, toItem: bottomContainerView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        
        bottomContainerView.addSubview(textView)
        NSLayoutConstraint(item: textView, attribute: .top, relatedBy: .equal, toItem: authorLabel, attribute: .bottom, multiplier: 1.0, constant: GridLayout.regularSpace * 3).isActive = true
        NSLayoutConstraint(item: textView, attribute: .leading, relatedBy: .equal, toItem: bottomContainerView, attribute: .leading, multiplier: 1.0, constant: GridLayout.regularSpace * 3).isActive = true
        NSLayoutConstraint(item: textView, attribute: .trailing, relatedBy: .equal, toItem: bottomContainerView, attribute: .trailing, multiplier: 1.0, constant: -GridLayout.regularSpace * 3).isActive = true
        NSLayoutConstraint(item: textView, attribute: .bottom, relatedBy: .equal, toItem: bottomContainerView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        
        bottomContainerView.addSubview(bottomGradientView)
        NSLayoutConstraint(item: bottomGradientView, attribute: .bottom, relatedBy: .equal, toItem: bottomContainerView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: bottomGradientView, attribute: .leading, relatedBy: .equal, toItem: bottomContainerView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: bottomGradientView, attribute: .trailing, relatedBy: .equal, toItem: bottomContainerView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: bottomGradientView, attribute: .height, relatedBy: .equal, toItem: bottomContainerView, attribute: .height, multiplier: 0.3, constant: 0).isActive = true
        
        addSubview(dismissButton)
        NSLayoutConstraint(item: dismissButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: GridLayout.regularSpace * 8).isActive = true
        NSLayoutConstraint(item: dismissButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: GridLayout.regularSpace * 3).isActive = true
        NSLayoutConstraint(item: dismissButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 26).isActive = true
        NSLayoutConstraint(item: dismissButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 21).isActive = true
    }
}
