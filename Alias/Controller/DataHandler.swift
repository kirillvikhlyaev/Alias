//
//  DataHandler.swift
//  Alias
//
//  Created by Кирилл on 29.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import Foundation


struct DataHandler {
    var amountCategories = 0
    
    mutating func loadJSON(filename: String) -> [CategoryData]? {
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url)
                if let categories = self.parseJSON(dictionary: data) as [CategoryData]?{
                    return categories
                }
            } catch {
                return nil
            }
            
        }
        return nil
    }
    
    
    mutating func getCategoryByIndex(index: Int, filename: String) -> CategoryData? {
        return self.loadJSON(filename: filename)?[index]
    }
    
    mutating func getRandomCategory(index: Int, filename: String) -> CategoryData? {
        // Исключать категорию если совпадает index
        return self.loadJSON(filename: filename)?[Int.random(in: 0...4)]
    }
    
    mutating func parseJSON(dictionary: Data) -> [CategoryData]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(Categories.self, from: dictionary)
            
            var categories = [CategoryData]()
            self.amountCategories = categories.count
            
            for i in 0...decodedData.categories.count-1 {
                let name = decodedData.categories[i].name
                let emoji = decodedData.categories[i].emoji
                let description = decodedData.categories[i].description
                let wordDict = decodedData.categories[i].wordsDict
                
                let categoryData = CategoryData(name: name, emoji: emoji, description: description, wordsDict: wordDict)
                
                categories.append(categoryData)
            }
            return categories
        } catch {
            return nil
        }
    }
}
