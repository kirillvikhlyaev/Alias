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
	init(categoryIndex: Int, teams: [String], chosenRoundTime: Int) {
        self.teams = teams
        self.chosenRoundTime = chosenRoundTime
        self.timeLeft = chosenRoundTime
        teamsScore = Array<Int>.init(repeating: 0, count: teams.count)
		
		let dataHandler = DataHandler()
		
		let path = Bundle.main.path(forResource: K.Strings.dictionary, ofType: "json")!
		let url = URL(fileURLWithPath: path)
		let data = try! Data(contentsOf: url)
		if let categories = dataHandler.parseJSON(dictionary: data) {
			self.categories = categories
			print("Parsed JSON")
		} else {
			self.categories = [CategoryData.example]
			print("Soething went wrong")
		}
		
		var wordsArray = [Word]()
		categories[categoryIndex].wordsDict.forEach({ wordsArray.append($0) })
		words = wordsArray
		//TODO: - выбирать рандомные 20% времени
    }
		
	var categories: [CategoryData]
    
    weak var delegate: GameModelDelegate?
	
    var gameState: GameState = .start
	
    private(set) var roundNum = 1
    
    private(set) var chosenRoundTime = 2
    
    private var currentWordIndex = 0

	private let words: [Word]
    
    var timer: Timer?
    var timeLeft = 10
    
    private var teams: [String]
    private var teamsScore: [Int]?
    private var currentTeamIndex = 0
    
    var currentTeam: String {
        teams[currentTeamIndex]
    }
	
    var jokeRequest = JokeRequest()
    
    var joke: String?
	
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
		words[currentWordIndex].word
    }
    
    func nextWord() -> String{
        currentWordIndex = words.count - 1 > currentWordIndex ? currentWordIndex + 1 : 0
        return currentWord
    }
    
    func increaseScore() {
		score += words[currentWordIndex].points
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
    
    func createJoke() {
        jokeRequest.request { joke in
            self.joke = "\(joke.setup) - \(joke.punchline)"
            print(self.joke)
        }
    }
}
