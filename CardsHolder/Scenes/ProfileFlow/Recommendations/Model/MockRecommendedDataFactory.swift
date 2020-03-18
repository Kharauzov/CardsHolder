//
//  MockRecommendedDataFactory.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 18.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

struct MockRecommendedDataFactory {
    struct ScienceGroup {
        let titles = [
            "Jelly fish",
            "The Cerulean",
            "Random Access",
            "The Sunrise",
            "Curious"
        ]
        let authors = [
            "Matt Tomson",
            "Amy Ewing",
            "Daft Pank",
            "John Liverstone",
            "Lavanda Grace"
        ]
        let rating = [
            3,
            4,
            5,
            4,
            3
        ]
    }
    
    struct MysteryGroup {
        let titles = [
            "The storm crow",
            "Night book",
            "The Metamorfoss",
            "Sea Legends",
            "Harry Potter"
        ]
        let authors = [
            "Kalyn Josephson",
            "J.A. White",
            "Kafka",
            "Maggie Tokuda",
            "J.K. Rowling"
        ]
        let rating = [
            5,
            4,
            3,
            5,
            4
        ]
    }
    
    func getData() -> [RecommendedCategory] {
        var data = [RecommendedCategory]() 
        // adding mystery items
        var mysteryItems = [RecommendedViewModel]()
        let mysteryGroup = MysteryGroup()
        for index in 0 ..< 5 {
            mysteryItems.append(RecommendedViewModel(title: mysteryGroup.titles[index], authorName: mysteryGroup.authors[index], rating: mysteryGroup.rating[index], coverImage: UIImage(named: "mystery_book\(index)")))
        }
        data.append(RecommendedCategory(title: "Mystery", items: mysteryItems))
        // adding science items
        var scienceItems = [RecommendedViewModel]()
        let scienceGroup = ScienceGroup()
        for index in 0 ..< 5 {
            scienceItems.append(RecommendedViewModel(title: scienceGroup.titles[index], authorName: scienceGroup.authors[index], rating: scienceGroup.rating[index], coverImage: UIImage(named: "science_book\(index)")))
        }
        data.append(RecommendedCategory(title: "Science", items: scienceItems))
        return data
    }
}
 
