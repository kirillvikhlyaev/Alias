//
//  DataHandler.swift
//  Alias
//
//  Created by Кирилл on 29.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import Foundation

protocol DataHandlerDelegate {
    func didFailWithError(error: Error)
    func didUpdateCategories(_ dataHandler: DataHandler, categories: [CategoryData])
}
 
struct DataHandler {
    var delegate: DataHandlerDelegate?
    
    func loadJSON(filename: String){
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
        let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url)
                if let categories = self.parseJSON(dictionary: data) as [CategoryData]?{
                    self.delegate?.didUpdateCategories(self, categories: categories)
                }
            } catch {
                delegate?.didFailWithError(error: error)
            }
        
        }
    }
    
    func parseJSON(dictionary: Data) -> [CategoryData]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(Categories.self, from: dictionary)
            
            var categories = [CategoryData]()
            
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
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
