//
//  SettingsViewController.swift
//  Alias
//
//  Created by Кирилл on 27.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import UIKit

class SettingsView: UIViewController {
	
	var chosenCategoryIndex: Int
	
	init(chosenCategoryIndex: Int = 0) {
		self.chosenCategoryIndex = chosenCategoryIndex
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//после выбра названий команд, нужно будет поместить их а массив, чтобы передать в gameViewController
	var teamNames = ["Голливудские голуби", "Якутские ящерицы"]
	
    var commandAmountValue = 2
    var category : CategoryData!
    
//    let gameView = GameViewController()
    
    let mainStack: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 25
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    let commandStack: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .equalCentering
        $0.spacing = 25
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
        
    }(UIStackView())
    
    let amountStack: UIStackView = {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .equalCentering
        $0.spacing = 25
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
        
    }(UIStackView())
    
    let commandValueTitle = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        buttonInit()
        setAmountChangeView()
        mainStack.addArrangedSubview(commandStack)
        view.addSubview(mainStack)
        setupMainStackConstraints()
        
        getCommandName(name: "Голливудские голуби")
        getCommandName(name: "Якутские ящерицы")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
	//MARK: - Тут еще есть пункт выбранное время, его тоже можно будет инициализировать если успеем реализовать это на вью, пока ставлю дефолтно 60 секунд
    @objc func onBtnToGameTap() {
        let vc = GameViewController(chosenCategoryIndex: chosenCategoryIndex, teams: teamNames, chosenRoundTime: 60)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupMainStackConstraints() {
        NSLayoutConstraint.activate([
            mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func setAmountChangeView() {
        
        let btnDecrement = UIButton()
        btnDecrement.backgroundColor = K.Colors.buttonsColor
        btnDecrement.setTitle("-", for: .normal)
        btnDecrement.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
        btnDecrement.layer.cornerRadius = 5
        btnDecrement.addTarget(self, action: #selector(commandAmountDecrement), for: .touchDown)
        
        let btnIncrement = UIButton()
        btnIncrement.backgroundColor = K.Colors.buttonsColor
        btnIncrement.setTitle("+", for: .normal)
        btnIncrement.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
        btnIncrement.layer.cornerRadius = 5
        btnIncrement.addTarget(self, action: #selector(commandAmountIncrement), for: .touchDown)
        
        
        commandValueTitle.text = String(commandAmountValue)
        commandValueTitle.textColor = .white
        
        //        let stepper = UIStepper()
        //        stepper.tintColor = .white
        
        
        mainStack.addArrangedSubview(amountStack)
        
        
        amountStack.addArrangedSubview(btnDecrement)
        amountStack.addArrangedSubview(commandValueTitle)
        amountStack.addArrangedSubview(btnIncrement)
        //        amountStack.addArrangedSubview(stepper)
    }
    
    @objc func commandAmountIncrement() {
        if commandAmountValue < 4 {
            commandAmountValue += 1
            commandValueTitle.text = String(commandAmountValue)
            getCommandName(name: "Утиные перышки")
        }
    }
    
    @objc func commandAmountDecrement() {
        if commandAmountValue > 2 {
            commandAmountValue -= 1
            commandValueTitle.text = String(commandAmountValue)
            // Удалить название из массива и из стака
        }
    }
    
    func getCommandName(name: String) {
        let command = UILabel()
        command.text = name // TODO: Вставка рандомного имени из списка, имена должны быть комичными
        command.font = .systemFont(ofSize: 32, weight: .bold)
        command.textColor = .white
        
        commandStack.addArrangedSubview(command)
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
    
    func buttonInit() {
        let buttonToGame = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        buttonToGame.backgroundColor = K.Colors.buttonsColor
        buttonToGame.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
        buttonToGame.layer.cornerRadius = 25
        buttonToGame.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonToGame.setTitle("Начать игру", for: .normal)
        buttonToGame.addTarget(self, action: #selector(onBtnToGameTap), for: .touchDown)
        buttonToGame.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(buttonToGame)
        
        let leftConstraint = NSLayoutConstraint(item: buttonToGame, attribute: .leftMargin, relatedBy: .equal, toItem: view, attribute: .leftMargin, multiplier: 1, constant: +40)
        
        let rightConstraint = NSLayoutConstraint(item: buttonToGame, attribute: .rightMargin, relatedBy: .equal, toItem: view, attribute: .rightMargin, multiplier: 1, constant: -40)
        
        let bottomConstraint = NSLayoutConstraint(item: buttonToGame, attribute: .bottomMargin, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1, constant: -25)
        
        view.addConstraints([leftConstraint, rightConstraint, bottomConstraint])
    }
}


// TODO(kirillvikhlyaev):
// 1. Добавить кнопку возле названия для удаления
// 2. Добавить мозги
// 3. Добавить словарик комичных названий
// 4. Динамическое добавление/убавление позиций
