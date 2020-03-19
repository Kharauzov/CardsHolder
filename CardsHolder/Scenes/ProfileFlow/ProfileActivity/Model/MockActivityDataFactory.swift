//
//  MockActivityDataFactory.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 05.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

struct MockActivityDataFactory {
    private let titles = [
        "The white raven",
        "Seasons of the storm",
        "Risoko",
        "Sorcery of thorns",
        "Goldeline",
        "The Rambling",
        "Angel and Bavar",
        "Unspoken"
    ]
    private let authors = [
        "Carrie D. Miller",
        "Elle Cosimano",
        "David Kudler",
        "Margaret Rogerson",
        "Jimmy Cajoleas",
        "Jimmy Cajoleas",
        "Amy Wilson",
        "Celia McMahon"
    ]
    func getData() -> [ActivityViewModel] {
        var data = [ActivityViewModel]()
        for index in 1 ... 8 {
            let progress = CGFloat.random(in: 0...1)
            data.append(ActivityViewModel(title: titles[index - 1], authorName: authors[index - 1], authorImage: #imageLiteral(resourceName: "avatar"), progress: progress, progressString: getFormattedProgressString(progress: progress), coverImage: UIImage(named: "cover\(index)")))
        }
        return data
    }
    
    private func getFormattedProgressString(progress: CGFloat) -> String {
        let formattedProgress = Int(progress * 100)
        return "\(formattedProgress)%"
    }
}
