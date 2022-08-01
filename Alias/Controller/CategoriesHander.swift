//
//  CategoriesHander.swift
//  Alias
//
//  Created by Кирилл on 01.08.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import Foundation


protocol CategoriesHandlerDelegate {
    func didFailWithError(error: Error)
    func didUpdateCategories(_ categoriesHandler: CategoriesHandler, categories: [CategoryData])
}

struct CategoriesHandler {
    var categories: [CategoryData] = []
    var amountOfCategories = 0;
    var dataHandler = DataHandler()
    var delegate : CategoriesHandlerDelegate?
    
    mutating func getCategories() {
        self.categories = dataHandler.loadJSON(filename: K.Strings.dictionary)!
        self.delegate?.didUpdateCategories(self, categories: categories)
    }
}
