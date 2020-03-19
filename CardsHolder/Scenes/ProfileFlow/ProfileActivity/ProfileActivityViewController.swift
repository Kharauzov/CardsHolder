//
//  ProfileActivityViewController.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 05.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class ProfileActivityViewController: UIViewController {

    lazy var customView = view as! ProfileActivityView
    var data = [ActivityViewModel]()
    var didSelectItem: ((_ selectedModel: ProfileActivitySelectedViewModel) -> Void)?
    var tableView: UITableView {
        return customView.tableView
    }
    
    override func loadView() {
        view = ProfileActivityView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.titleLabel.text = "Activity"
        setupTableView()
        loadData()
        tableView.reloadData()
    }
    
    private func loadData() {
        data = MockActivityDataFactory().getData()
    }
    
    private func setupTableView() {
        tableView.register(ActivityTableViewCell.self, forCellReuseIdentifier: ActivityTableViewCell.description())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.bottom = CardsHolderView.Constants.subviewBottomOffset
    }
}

extension ProfileActivityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCell.description(), for: indexPath) as? ActivityTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(from: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 142
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ActivityTableViewCell else {
            return
        }
        let imageRelativeFrame = view.convert(cell.coverImageView.frame, from: cell.containerView)
        let model = ProfileActivitySelectedViewModel(item: data[indexPath.row], imageView: cell.coverImageView, imageViewParentRelativeFrame: imageRelativeFrame)
        DispatchQueue.main.async {
            self.didSelectItem?(model)
        }
    }
}
