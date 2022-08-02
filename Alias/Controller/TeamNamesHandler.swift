//
//  TeamNamesHandler.swift
//  Alias
//
//  Created by Кирилл on 02.08.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import Foundation

struct TeamNamesHandler {
    
    var teamsNames : [String] = []
    
    mutating func loadJSON(filename: String) -> [String]? {
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url)
                if let names = self.parseJSON(teamNamesJSON: data) as [String]?{
                    return names
                }
            } catch {
                return nil
            }
            
        }
        return nil
    }
    
    mutating func parseJSON(teamNamesJSON: Data) -> [String]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(TeamNamesModel.self, from: teamNamesJSON)
            
            self.teamsNames = decodedData.teamNames

            return teamsNames
        } catch {
            return nil
        }
    }
}


