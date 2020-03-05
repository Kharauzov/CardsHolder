//
//  ActivityTableViewCell.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 05.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    private static let blackTextColor = UIColor(hexString: "#060518")
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 9
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = blackTextColor
        label.font = .customFont(ofSize: 14, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let authorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = blackTextColor
        label.font = UIFont.customFont(ofSize: 12, weight: .medium)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let progressView: ProgressView = {
        let view = ProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let progressLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#656464")
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialise()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(from model: ActivityViewModel) {
        titleLabel.text = model.title
        authorNameLabel.text = model.authorName
        avatarImageView.image = model.authorImage
        coverImageView.image = model.coverImage
        progressView.update(progress: model.progress)
        progressLabel.text = model.progressString
    }
    
    private func initialise() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubviews()
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: GridLayout.regularSpace).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: -GridLayout.regularSpace).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: GridLayout.regularSpace * 3).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: -GridLayout.regularSpace * 3).isActive = true
        
        containerView.addSubview(coverImageView)
        NSLayoutConstraint(item: coverImageView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: GridLayout.doubleRegularSpace).isActive = true
        NSLayoutConstraint(item: coverImageView, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1.0, constant: GridLayout.doubleRegularSpace).isActive = true
        NSLayoutConstraint(item: coverImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 90).isActive = true
        NSLayoutConstraint(item: coverImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 70).isActive = true
        
        containerView.addSubview(titleLabel)
        NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: coverImageView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: coverImageView, attribute: .trailing, multiplier: 1.0, constant: GridLayout.doubleRegularSpace).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1.0, constant: -GridLayout.doubleRegularSpace).isActive = true
        
        containerView.addSubview(progressView)
        containerView.addSubview(progressLabel)
        NSLayoutConstraint(item: progressLabel, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1.0, constant: -GridLayout.doubleRegularSpace).isActive = true
        NSLayoutConstraint(item: progressLabel, attribute: .centerY, relatedBy: .equal, toItem: progressView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: progressView, attribute: .bottom, relatedBy: .equal, toItem: coverImageView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: progressView, attribute: .leading, relatedBy: .equal, toItem: coverImageView, attribute: .trailing, multiplier: 1.0, constant: GridLayout.doubleRegularSpace).isActive = true
        NSLayoutConstraint(item: progressView, attribute: .trailing, relatedBy: .equal, toItem: progressLabel, attribute: .leading, multiplier: 1.0, constant: -10).isActive = true
        NSLayoutConstraint(item: progressView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 6).isActive = true
        
        containerView.addSubview(avatarImageView)
        NSLayoutConstraint(item: avatarImageView, attribute: .leading, relatedBy: .equal, toItem: coverImageView, attribute: .trailing, multiplier: 1.0, constant: GridLayout.doubleRegularSpace).isActive = true
        NSLayoutConstraint(item: avatarImageView, attribute: .bottom, relatedBy: .equal, toItem: progressView, attribute: .top, multiplier: 1.0, constant: -GridLayout.doubleRegularSpace).isActive = true
        NSLayoutConstraint(item: avatarImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: avatarImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20).isActive = true
        
        containerView.addSubview(authorNameLabel)
        NSLayoutConstraint(item: authorNameLabel, attribute: .leading, relatedBy: .equal, toItem: avatarImageView, attribute: .trailing, multiplier: 1.0, constant: GridLayout.regularSpace).isActive = true
        NSLayoutConstraint(item: authorNameLabel, attribute: .centerY, relatedBy: .equal, toItem: avatarImageView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
    }
}
