//
//  SettingsController.swift
//  Alias
//
//  Created by Кирилл on 02.08.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import Foundation
protocol SettingsHandlerDelegete {
    func didFailWithError(error: Error)
    func didUpdateCategories(_ settingsHandler: SettingsHandler, team: [String])
}
struct SettingsHandler {
    var delegate: SettingsHandlerDelegete?
    
    var playngTimeInSec = 60
    
    var allTeamNames : [String] = []
    var teams : [String] = []
    
    var teamNamesHandler = TeamNamesHandler()
    
    mutating func setupTeams() {
        self.allTeamNames = teamNamesHandler.loadJSON(filename: "teamNames")!
        
//        teams.append(allTeamNames[Int.random(in: 0...allTeamNames.count-1)])
//        teams.append(allTeamNames[Int.random(in: 0...allTeamNames.count-1)])
        print(teams.count)
        delegate?.didUpdateCategories(self, team: allTeamNames)
    }
    
    mutating func getNewTeam() {
        let randomTeam = allTeamNames[Int.random(in: 0...allTeamNames.count-1)]
        teams.append(randomTeam)
//        delegate?.didUpdateCategories(self, team: teams)
    }
    
    mutating func removeTeam () {
        if !teams.isEmpty {
            teams.removeLast()
        }
//        delegate?.didUpdateCategories(self, team: teams)
    }
    
    func getCommandAmount() -> Int {
        return teams.count
    }
}
