//
//  RecommendationsViewController.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 05.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class RecommendationsViewController: UIViewController {

    lazy var customView = view as! RecommendationsView
    var data = [RecommendedCategory]()
    var sliderViewControllers = [RecommendationsSliderViewController]()
    var tableView: UITableView {
        return customView.tableView
    }
    
    override func loadView() {
        view = RecommendationsView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.titleLabel.text = "Recommended"
        setupTableView()
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    private func loadData() {
        data = MockRecommendedDataFactory().getData()
        data.forEach { (item) in
            sliderViewControllers.append(getChildRecommendedViewController(from: item))
        }
    }
    
    private func setupTableView() {
        tableView.register(RecommendedCategoryTableViewCell.self, forCellReuseIdentifier: RecommendedCategoryTableViewCell.description())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.bottom = CardsHolderView.Constants.subviewBottomOffset
    }
    
    private func getChildRecommendedViewController(from category: RecommendedCategory) -> RecommendationsSliderViewController {
        let viewController = RecommendationsSliderViewController(viewModel: category)
        addChild(viewController)
        viewController.didMove(toParent: self)
        return viewController
    }
}

extension RecommendationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sliderViewControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommendedCategoryTableViewCell.description(), for: indexPath) as? RecommendedCategoryTableViewCell else {
            return UITableViewCell()
        }
        cell.hostedView = sliderViewControllers[indexPath.row].view
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 315
    }
}
