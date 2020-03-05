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
        "The lord of the rings: The Fellowship of the Ring",
        "Harry Potter and the Philosopher's Stone",
        "Adventures of Huckleberry Finn",
        "The Lion, the Witch and the Wardrobe",
        "The Da Vinci Code",
        "The Alchemist",
        "To kill a mockingbird",
        "Gone with the wind",
        "The Great Gatsby",
        "The hunger games",
        "The Godfather"
    ]
    private let authors = [
        "J. R. R. Tolkien",
        "J. K. Rowling",
        "Mark Twain",
        "C. S. Lewis",
        "Dan Brown",
        "Paulo Coelho",
        "Harper Lee",
        "Margaret Mitchell",
        "F. Scott Fitzgerald",
        "Suzanne Collins",
        "Mario Puzo"
    ]
    func getData() -> [ActivityViewModel] {
        var data = [ActivityViewModel]()
        for index in 1 ... 11 {
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
