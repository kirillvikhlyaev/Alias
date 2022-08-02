//
//  SettingsViewController.swift
//  Alias
//
//  Created by Кирилл on 27.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//
import UIKit

class SettingsView: UIViewController {
    
	private var chosenCategoryIndex: Int
    
    init(chosenCategoryIndex: Int = 0) {
        self.chosenCategoryIndex = chosenCategoryIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var chosenTime = 60
	private var teamsOnScreen: [TeamWithColor] = []
	private var teamsBase: [String] = []
    
	private var numberOfTeams = 0
	private var settingsHandler = SettingsHandler()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setBackground()
		timerSlider.setValue(Float(chosenTime), animated: false)

		settingsHandler.delegate = self
		settingsHandler.setupTeams()
		
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(TeamCell.self, forCellReuseIdentifier: K.Strings.teamCell)
		tableView.rowHeight = 100
		
		view.addSubview(mainStack)
		view.addSubview(tableView)
		view.addSubview(timerStack)
		view.addSubview(startGameButton)
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.heightAnchor.constraint(equalToConstant: 500),
			
			mainStack.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 30),
			mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			mainStack.heightAnchor.constraint(equalToConstant: 100),
			
			timerStack.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 30),
			timerStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
			timerStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
			timerStack.heightAnchor.constraint(equalToConstant: 100),
			
			startGameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			startGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			startGameButton.widthAnchor.constraint(equalToConstant: 200),
			startGameButton.heightAnchor.constraint(equalToConstant: 60)
		])
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = true
	}
	
	private var tableView: UITableView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.backgroundColor = .clear
		return $0
	}(UITableView())
	
	lazy private var stepper: UIStepper = {
		let stepper = UIStepper()
		stepper.value = Double(numberOfTeams)
		stepper.minimumValue = 0
		stepper.maximumValue = 4
		stepper.tintColor = K.Colors.buttonsColor
		stepper.setDecrementImage(stepper.decrementImage(for: .normal), for: .normal)
		stepper.setIncrementImage(stepper.incrementImage(for: .normal), for: .normal)
		stepper.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
		stepper.autoresizesSubviews = true
		stepper.addTarget(nil, action: #selector(stepperPressed(_:)), for: .valueChanged)
		return stepper
	}()
	
	lazy private var timerSlider: UISlider = {
		let slider = UISlider()
		slider.minimumValue = 20
		slider.maximumValue = 200
		slider.minimumTrackTintColor = K.Colors.appLightBlue
		slider.tintColor = K.Colors.appBlue
		slider.thumbTintColor = K.Colors.buttonsColor
		
		slider.addTarget(self, action: #selector(sliderMoved), for: .valueChanged)
		return slider
	}()
	
	lazy private var timerLabel: UILabel = {
		let label = PaddingLabel(withInsets: 10, 10, 12, 12)
		label.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
		label.font = UIFont.systemFont(ofSize: 40)
		label.text = "\(chosenTime)"
		label.textColor = .white
		label.backgroundColor = UIColor.darkGray
		label.layer.masksToBounds = true
		label.layer.cornerRadius = label.bounds.height / 4
		return label
	}()
	
	lazy private var teamsNumberLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.text = "\(numberOfTeams)"
		label.numberOfLines = 0
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
		return label
	}()
	
	lazy private var timerStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [timerSlider, timerLabel])
		stack.spacing = 30
		stack.alignment = .center
		stack.distribution = .fill
		stack.axis = .horizontal
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	lazy private var mainStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [teamsNumberLabel, stepper])
		stack.spacing = 20
		stack.alignment = .center
		stack.distribution = .fillProportionally
		stack.axis = .vertical
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	private var startGameButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = K.Colors.buttonsColor
		button.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
		button.layer.cornerRadius = 25
		button.setTitle("Начать игру", for: .normal)
		button.setTitleColor(UIColor.white, for: .normal)
		button.addTarget(nil, action: #selector(startButtonPressed), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	@objc func sliderMoved() {
		chosenTime = Int(timerSlider.value)
		timerLabel.text = "\(chosenTime)"
	}
	
	@objc func stepperPressed(_ sender: UIStepper) {
		let stepperValue = Int(stepper.value)
		stepperValue > numberOfTeams ? addTeam() : removeTeam(at: teamsOnScreen.count - 1)
		numberOfTeams = stepperValue
		teamsNumberLabel.text = "\(numberOfTeams)"
		
		print(sender.stepValue)
	}
	
	func addTeam() {
		var newName = teamsBase.randomElement()
		while teamsOnScreen.contains(where: { $0.name == newName }) {
			newName = teamsBase.randomElement()
		}
		var newColor = K.Colors.cardColors.randomElement()
		while teamsOnScreen.contains(where: { $0.color == newColor }) {
			newColor = K.Colors.cardColors.randomElement()
		}
		teamsOnScreen.append(TeamWithColor(name: newName ?? "Empty", color: newColor ?? .blue))
		numberOfTeams += 1
		tableView.reloadData()
		updateStartButton()
	}
	
	func removeTeam(at index: Int) {
		teamsOnScreen.remove(at: index)
		numberOfTeams -= 1
		teamsNumberLabel.text = "\(numberOfTeams)"
		stepper.value = Double(numberOfTeams)
		tableView.reloadData()
		updateStartButton()
	}
	
	func updateStartButton() {
		UIView.animate(withDuration: 0.2) {
			if self.numberOfTeams < 2 {
				self.startGameButton.isEnabled = false
				self.startGameButton.layer.opacity = 0.7
			} else {
				self.startGameButton.isEnabled = true
				self.startGameButton.layer.opacity = 1
			}
		}
	}
    
    //MARK: - Тут еще есть пункт выбранное время, его тоже можно будет инициализировать если успеем реализовать это на вью, пока ставлю дефолтно 60 секунд
    @objc func startButtonPressed() {
		var teams = [String]()
		teamsOnScreen.forEach({ teams.append($0.name) })
        let vc = GameViewController(chosenCategoryIndex: chosenCategoryIndex, teams: teams, chosenRoundTime: chosenTime)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SettingsView: SettingsHandlerDelegete {
    func didFailWithError(error: Error) {
        print("error")
    }
    
    func didUpdateCategories(_ settingsHandler: SettingsHandler, team: [String]) {
        self.teamsBase = team
		for _ in 0..<2 {
			addTeam()
		}
    }
    
    
}

// MARK: - View Setup
extension SettingsView {
    
    func setBackground() {
        let backgroindImage = UIImage(named: K.Strings.backgroundImage)
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = backgroindImage
        imageView.center = view.center
        
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
}

extension SettingsView: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
	{
		let verticalPadding: CGFloat = 8
		let horizontalPadding: CGFloat = 8
		let maskLayer = CALayer()
		maskLayer.cornerRadius = 20  //if you want round edges
		maskLayer.backgroundColor = UIColor.black.cgColor
		maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: horizontalPadding, dy: verticalPadding/2)
		cell.layer.mask = maskLayer
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return teamsOnScreen.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: K.Strings.teamCell, for: indexPath) as! TeamCell
		let team = teamsOnScreen[indexPath.row]
		cell.setupCell(team.name)
		cell.backgroundColor = team.color
		return cell
	}
}

extension SettingsView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [self] _,_,_ in
			self.removeTeam(at: indexPath.row)
		}
		return UISwipeActionsConfiguration(actions: [deleteAction])
	}
}
