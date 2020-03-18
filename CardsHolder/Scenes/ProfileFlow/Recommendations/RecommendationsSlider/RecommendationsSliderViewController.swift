//
//  RecommendationsSliderViewController.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 18.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class RecommendationsSliderViewController: UIViewController {

    lazy var customView = view as! RecommendationsSliderView
    let collectionViewLayout: UICollectionViewFlowLayout = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: 144, height: 250)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: GridLayout.regularSpace * 3, bottom: 0, right: GridLayout.regularSpace * 3)
        collectionViewLayout.minimumLineSpacing = GridLayout.doubleRegularSpace
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.scrollDirection = .horizontal
        return collectionViewLayout
    }()
    var collectionView: UICollectionView {
        return customView.collectionView
    }
    let viewModel: RecommendedCategory
    
    override func loadView() {
        view = RecommendationsSliderView(frame: .zero)
    }
    
    init(viewModel: RecommendedCategory) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.titleLabel.text = viewModel.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCollectionView()
        collectionView.reloadData()
    }
    
    func setupCollectionView() {
        collectionView.register(RecommendedItemCollectionViewCell.self, forCellWithReuseIdentifier: RecommendedItemCollectionViewCell.description())
        collectionView.setCollectionViewLayout(collectionViewLayout, animated: false)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension RecommendationsSliderViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedItemCollectionViewCell.description(), for: indexPath) as? RecommendedItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(from: viewModel.items[indexPath.row])
        return cell
    }
}
