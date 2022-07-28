//
//  GameViewController.swift
//  Alias
//
//  Created by Кирилл on 27.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

	convenience init(wordsDict: [String: Int], teams: [String], chosenRoundTime: Int) {
		self.init()
		gameModel = GameModel(wordsDict: wordsDict, teams: teams, chosenRoundTime: chosenRoundTime)
	}
	
	var gameModel = GameModel(wordsDict: ["Apple": 1, "Watermelon": 1, "Rain": 4, "Field": 1], teams: ["Рыбы", "Коти", "Повелители"], chosenRoundTime: 10)
	
	var cardCurrentOffset: CGFloat = Constants.cardInitialOffset
	var cardTopAnchor: NSLayoutConstraint?
	
	override func viewDidLoad() {
		super.viewDidLoad()
				
		gameModel.delegate = self
		
		updateTimer()
		setupNewGame()
		cardButton.setTitle(gameModel.currentWord, for: .normal)
		
		view.addSubview(topStack)
		view.addSubview(cardButton)
		view.addSubview(buttonsStack)
		view.addSubview(pauseButton)
		view.addSubview(skipCardButton)
		view.addSubview(gameStateBackground)
		view.addSubview(startGameButton)
		
		
		NSLayoutConstraint.activate([
			
			topStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
			topStack.heightAnchor.constraint(equalToConstant: 150),
			topStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			topStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			
			cardButton.widthAnchor.constraint(equalToConstant: 250),
			cardButton.heightAnchor.constraint(equalToConstant: 250),
			cardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			
			pauseButton.bottomAnchor.constraint(equalTo: buttonsStack.topAnchor, constant: -20),
			pauseButton.heightAnchor.constraint(equalToConstant: 60),
			pauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			
			buttonsStack.bottomAnchor.constraint(equalTo: skipCardButton.topAnchor, constant: -20),
			buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
			buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
			
			skipCardButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
			skipCardButton.heightAnchor.constraint(equalToConstant: 60),
			skipCardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			
			gameStateBackground.topAnchor.constraint(equalTo: view.topAnchor),
			gameStateBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			gameStateBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			gameStateBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			
			startGameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			startGameButton.heightAnchor.constraint(equalToConstant: 200),
			startGameButton.widthAnchor.constraint(equalToConstant: 200),
			startGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		cardTopAnchor?.isActive = false
		//MARK: - why 325? magic number?
		cardTopAnchor = cardButton.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: cardCurrentOffset - Constants.magicNumber)
		cardTopAnchor?.isActive = true
	}
	
	override func viewWillAppear(_ animated: Bool) {
		setGradientBackground()
		setupGameStateBackground()
		super.viewWillAppear(animated)
	}
	
	func setGradientBackground() {
		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = [K.Colors.appBlue.cgColor, K.Colors.appLightBlue.cgColor,K.Colors.appLightBlue.cgColor,  K.Colors.appBlue.cgColor]
		gradientLayer.locations = [0.0, 0.4, 0.6, 1.0]
		gradientLayer.startPoint = .init(x: 0, y: 0) // top left
		gradientLayer.endPoint = .init(x: 1, y: 1)
		gradientLayer.frame = view.bounds
		view.layer.insertSublayer(gradientLayer, at:0)
	}
	
	lazy var gameStateLabel: UILabel = {
		let label = UILabel()
		label.frame = CGRect(x: 0, y: 200, width: view.bounds.width, height: 400)
		label.numberOfLines = 0
		label.text = "Team 1 is ready to ROCK?"
		label.textColor = .white
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 50, weight: .heavy)
		return label
	}()
	
	lazy private var gameStateBackground: UIView = {
		let view = UIView()
		view.addSubview(gameStateLabel)
		view.layer.opacity = 0.95
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	func setupGameStateBackground() {
		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = [K.Colors.appBlue.cgColor, K.Colors.appLightBlue.cgColor]
		gradientLayer.locations = [0.0, 1.0]
		gradientLayer.startPoint = .init(x: 0, y: 0) // top left
		gradientLayer.endPoint = .init(x: 1, y: 1)
		gradientLayer.frame = self.view.bounds
		gameStateBackground.layer.insertSublayer(gradientLayer, at:0)
	}
	
	private var startGameButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = K.Colors.appLightBlue
		button.layer.cornerRadius = 100
		button.clipsToBounds = true
		button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
		button.setTitle("СТАРТ!", for: .normal)
		button.setTitleColor(K.Colors.appBlue, for: .normal)
		button.titleLabel?.adjustsFontSizeToFitWidth = true
		button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(nil, action: #selector(startGameButtonPressed), for: .touchUpInside)
		button.layer.shadowColor = K.Colors.appBlue.cgColor
		button.layer.shadowOffset = CGSize(width: 0, height: 0)
		button.layer.shadowOpacity = 1.0
		button.layer.shadowRadius = 8
		button.layer.masksToBounds = false
		return button
	}()
	
	lazy private var topStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [scoreLabel, timerLabel])
		stack.spacing = 20
		stack.alignment = .center
		stack.distribution = .fillProportionally
		stack.axis = .vertical
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	lazy private var timerLabel: UILabel = {
		let label = PaddingLabel(withInsets: 10, 10, 12, 12)
		label.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
		label.font = UIFont.systemFont(ofSize: 70)
		label.textColor = .white
		label.backgroundColor = UIColor.darkGray
		label.layer.masksToBounds = true
		label.layer.cornerRadius = label.bounds.height / 4
		return label
	}()
	
	lazy private var scoreLabel: UILabel = {
		let label = PaddingLabel(withInsets: 10, 10, 12, 12)
		label.font = UIFont.systemFont(ofSize: 30)
		label.textColor = .white
		label.text = gameModel.scoreForTeam
		label.backgroundColor = UIColor.darkGray
		label.layer.masksToBounds = true
		label.layer.cornerRadius = 10
		return label
	}()
	
	
	lazy private var cardButton: UIButton = {
		let card = UIButton(type: .custom)
		card.setTitleColor(UIColor.label, for: .normal)
		card.backgroundColor = .secondarySystemBackground
		card.titleLabel?.font = UIFont.systemFont(ofSize: 40)
		card.clipsToBounds = true
		card.layer.cornerRadius = Constants.cardHeight / 2
		card.isUserInteractionEnabled = true
		card.layer.shadowColor = UIColor.black.cgColor
		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCard(_:)))
		card.addGestureRecognizer(panGesture)
		card.translatesAutoresizingMaskIntoConstraints = false
		card.layer.shadowColor = K.Colors.appBlue.cgColor
		card.layer.shadowOffset = CGSize(width: 0, height: 0)
		card.layer.shadowOpacity = 1.0
		card.layer.shadowRadius = 8
		card.layer.masksToBounds = false
		return card
	}()
	
	lazy private var buttonsStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [wrongAnswerButton, rightAnswerButton])
		stack.axis = .horizontal
		stack.distribution = .fillEqually
		stack.spacing = 30
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	private var pauseButton: UIButton = {
		let button = UIButton(type: .system)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
		button.setTitle("  ПАУЗА", for: .normal)
		button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		button.backgroundColor = UIColor.darkGray
		button.clipsToBounds = true
		button.layer.cornerRadius = 30
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(nil, action: #selector(pauseButtonPressed), for: .touchUpInside)
		return button
	}()
	
	private var rightAnswerButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("👍", for: .normal)
		button.tag = 0
		button.backgroundColor = UIColor.green
		button.layer.cornerRadius = 30
		button.clipsToBounds = true
		button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
		button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		button.addTarget(nil, action: #selector(controlButtonPressed(_:)), for: .touchUpInside)
		return button
	}()
	
	private var wrongAnswerButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("👎", for: .normal)
		button.tag = 1
		button.backgroundColor = UIColor.red
		button.layer.cornerRadius = 30
		button.clipsToBounds = true
		button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
		button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		button.addTarget(nil, action: #selector(controlButtonPressed(_:)), for: .touchUpInside)
		return button
	}()

	private var skipCardButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Сбросить", for: .normal)
		button.tag = 2
		button.setTitleColor(UIColor.white, for: .normal)
		button.backgroundColor = UIColor.lightGray
		button.setImage(UIImage(systemName: "arrow.down"), for: .normal)
		button.layer.cornerRadius = 30
		button.clipsToBounds = true
		button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
		button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
		button.addTarget(nil, action: #selector(controlButtonPressed(_:)), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	@objc func startGameButtonPressed() {
		if gameModel.gameState == .roundFinished {
			setupNewGame()
			return
		}
		gameModel.startGame()
	}
	
	@objc func pauseButtonPressed() {
		let str = "Пауза\n\n\(gameModel.scoreForTeam)"
		gameStateLabel.text = str
		startGameButton.setTitle("Продолжить", for: .normal)
		gameModel.stopGame()
	}
	
	@objc func panCard(_ gesture: UIPanGestureRecognizer) {
		let translation = gesture.translation(in: view)
		guard let gestureView = gesture.view else { return }
		
		cardCurrentOffset = gestureView.center.y + translation.y
		
		gestureView.center.y = cardCurrentOffset
		
		gesture.setTranslation(.zero, in: view)
		
		let totalOffset = Float(abs(cardCurrentOffset - Constants.cardInitialOffset))
		
		if cardCurrentOffset < Constants.cardInitialOffset {
			let color = UIColor(hue: 0.3, saturation: (CGFloat(totalOffset) * 0.005), brightness: 1, alpha: 1)
			cardButton.backgroundColor = color
		} else {
			let color = UIColor(hue: 0, saturation: (CGFloat(totalOffset) * 0.005), brightness: 1, alpha: 1)
			cardButton.backgroundColor = color
		}
		
		if totalOffset > 50 {
			cardButton.layer.opacity = 1 - (totalOffset * 0.005)
		}
		
		switch gesture.state {
			case .ended :
				UIView.animate(withDuration: 0.2) {
					self.cardButton.backgroundColor = .white
					self.cardButton.layer.opacity = 1
					
					//TODO: make smooth card returning
//					let offsetToMove = self.cardCurrentOffset - Constants.cardInitialOffset < 0 ? (totalOffset - 50) * (-1) : totalOffset - 50
//					self.cardButton.transform = CGAffineTransform(translationX: 0, y: CGFloat(offsetToMove))
					self.cardCurrentOffset = Constants.cardInitialOffset
				}
				view.setNeedsLayout()
			case .cancelled:
				//change score
				cardCurrentOffset - Constants.cardInitialOffset < 0
				? gameModel.increaseScore() : gameModel.decreaseScore()
				
				updateScoreLabel()
				if gameModel.gameState == .lastCard {
					gameModel.lastCardPlayed()
				}
				
				//update card word
				cardButton.isOpaque = true
				cardButton.backgroundColor = .white
				cardButton.setTitle(gameModel.nextWord(), for: .normal)
				cardCurrentOffset = Constants.cardInitialOffset

				DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
					UIView.animate(withDuration: 0.2) {
						self.cardButton.layer.opacity = 1
					}
				}
			default: print("Other panGesture case")
		}
		
		if totalOffset > 200 {
			gesture.state = .cancelled
		}

	}
	
	func updateScoreLabel() {
		scoreLabel.text = gameModel.scoreForTeam
	}
	
	@objc func controlButtonPressed(_ sender: UIButton) {
		UIView.animate(withDuration: 0.3) {
			if sender.tag == 0 {
				self.cardButton.transform = CGAffineTransform(translationX: 0, y: -500)
				self.gameModel.increaseScore()
			} else {
				self.cardButton.transform = CGAffineTransform(translationX: 0, y: 500)
				self.gameModel.decreaseScore()
			}
			self.cardButton.layer.opacity = 0
		}
		updateScoreLabel()
		
		if gameModel.gameState == .lastCard {
			gameModel.lastCardPlayed()
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
			self.cardButton.setTitle(self.gameModel.nextWord(), for: .normal)
			self.cardButton.transform = CGAffineTransform(translationX: 0, y: 0)
			UIView.animate(withDuration: 0.2) {
				self.cardButton.layer.opacity = 1
			}
		}
	}
}

extension GameViewController: GameModelDelegate {
	
	func stopGame() {
		cardButton.isUserInteractionEnabled = false
		rightAnswerButton.isUserInteractionEnabled = false
		wrongAnswerButton.isUserInteractionEnabled = false
		skipCardButton.isUserInteractionEnabled = false
		gameStateBackground.layer.opacity = 0
		startGameButton.layer.opacity = 0
		gameStateBackground.isHidden = false
		startGameButton.isHidden = false
		UIView.animate(withDuration: 0.2) {
			self.gameStateBackground.layer.opacity = 1
			self.startGameButton.layer.opacity = 1
		}
		startGameButton.setTitle("Продолжить", for: .normal)
	}
	func startGame() {
		UIView.animate(withDuration: 0.2) {
			self.gameStateBackground.layer.opacity = 0
			self.startGameButton.layer.opacity = 0
		}
		
		cardButton.isUserInteractionEnabled = true
		rightAnswerButton.isUserInteractionEnabled = true
		wrongAnswerButton.isUserInteractionEnabled = true
		skipCardButton.isUserInteractionEnabled = true
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
			self.gameStateBackground.isHidden = true
			self.startGameButton.isHidden = true
		}
	}
	func updateTimer() {
		timerLabel.text = "\(gameModel.timeLeft)"
	}
	
	func showResultsOfRound(results: String) {
		startGameButton.setTitle("Понятно", for: .normal)
		gameStateLabel.text = results
	}
	
	func setupNewGame() {
		gameModel.gameState = .start
		updateTimer()
		updateScoreLabel()
		startGameButton.setTitle("ПОЕХАЛИ!", for: .normal)
		gameStateLabel.text = "\(gameModel.currentTeam) готовы ЖЕЧЬ?"
	}
}

struct Constants {
	static var cardHeight = 250.0
	static var cardInitialOffset = cardHeight * 1.5
	
	static let magicNumber = 325.0
}

protocol GameModelDelegate: AnyObject {
	func startGame()
	func stopGame()
	func updateTimer()
	func setupNewGame()
	func showResultsOfRound(results: String)
}
