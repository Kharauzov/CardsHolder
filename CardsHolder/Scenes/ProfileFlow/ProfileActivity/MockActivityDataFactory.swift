//
//  MockActivityDataFactory.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 05.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

struct MockActivityDataFactory {
    func getData() -> [ActivityViewModel] {
        return [
            
            ActivityViewModel(title: "Search Engine Optimization And Advertising", authorName: "John Doe", authorImage: #imageLiteral(resourceName: "avatar"), progress: 0.5, progressString: getFormattedProgressString(progress: 0.5), coverImage: #imageLiteral(resourceName: "avatar"))
        ]
    }
    
    private func getFormattedProgressString(progress: CGFloat) -> String {
        let formattedProgress = Int(progress * 100)
        return "\(formattedProgress)%"
    }
}
