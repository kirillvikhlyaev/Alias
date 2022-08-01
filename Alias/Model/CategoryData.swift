//
//  CategoryModel.swift
//  Alias
//
//  Created by Кирилл on 29.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import Foundation

struct Categories: Decodable {
    let categories: [CategoryData]
}

struct CategoryData: Decodable {
    let name: String
    let emoji: String
    let description: String
    let wordsDict: [Word]
	
	static let example = CategoryData(name: "Example", emoji: "🤪", description: "", wordsDict: [Word(word: "Example", points: 1)])
}

struct Word: Decodable {
    let word: String
    let points: Int
}
