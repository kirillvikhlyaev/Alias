//
//  GameModel.swift
//  Alias
//
//  Created by Сергей Цайбель on 27.07.2022.
//

import UIKit

enum GameState {
	//last card means that after time is over game is waiting
	//when card will be guessed or no and change team
	case start, playing, lastCard, paused, roundFinished
}

class GameModel {
	init(wordsDict: [String:Int], teams: [String], chosenRoundTime: Int) {
		self.wordsDict = wordsDict
		self.words = wordsDict.keys.map({ $0 })
		self.teams = teams
		self.chosenRoundTime = chosenRoundTime
		self.timeLeft = chosenRoundTime
		teamsScore = Array<Int>.init(repeating: 0, count: teams.count)
	}
	
	weak var delegate: GameModelDelegate?
	var gameState: GameState = .start {
		didSet {
			
		}
	}
	private(set) var roundNum = 1
	
	private(set) var chosenRoundTime = 2
	
	private var currentWordIndex = 0
	private let wordsDict: [String:Int]
	private let words: [String]
	
	var timer: Timer?
	var timeLeft = 10
	
	private var teams: [String]
	private var teamsScore: [Int]?
	private var currentTeamIndex = 0
	
	var currentTeam: String {
		teams[currentTeamIndex]
	}
	
	private var score: Int {
		get {
			teamsScore![currentTeamIndex]
		}
		set {
			teamsScore![currentTeamIndex] = newValue
		}
	}
	
	var interfaceEnabled = false
	
	var scoreForTeam: String {
		"\(currentTeam): \(score)"
	}
	
	var currentWord : String {
		words[currentWordIndex]
	}
	
	func nextWord() -> String{
		currentWordIndex = wordsDict.count - 1 > currentWordIndex ? currentWordIndex + 1 : 0
		return currentWord
	}
	
	func increaseScore() {
		score += wordsDict[currentWord]!
	}
	
	func decreaseScore() {
		score -= 1
	}
	
	func startGame() {
		timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
		delegate?.startGame()
		gameState = .playing
	}
	
	func stopGame() {
		timer?.invalidate()
		delegate?.stopGame()
	}
	
	@objc func updateTimer() {
		if timeLeft > 0 {
			timeLeft -= 1
			delegate?.updateTimer()
		} else {
			timer?.invalidate()
			gameState = .lastCard
		}
	}
	
	func lastCardPlayed() {
		delegate?.stopGame()
		timeLeft = chosenRoundTime
		
		if teams.count - 1 > currentTeamIndex {
			currentTeamIndex += 1
			delegate?.setupNewGame()
		} else {
			currentTeamIndex = 0
			gameState = .roundFinished
			var results = "Раунд \(roundNum)\n Счет: \n"
			for i in 0..<teams.count {
				let str = " \(teams[i])   \(teamsScore![i]) \n"
				results.append(contentsOf: str)
			}
			delegate?.showResultsOfRound(results: results)
			roundNum += 1
		}
	}
}