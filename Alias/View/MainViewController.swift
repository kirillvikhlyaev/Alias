//
//  ViewController.swift
//  Alias
//
//  Created by Кирилл on 26.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let stack: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.spacing = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stack)
        buttonsInit()
        initStackConstraints()
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Clicked!")
    }
    
    func initStackConstraints() {
        NSLayoutConstraint.activate([
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func buttonsInit() {
        let buttonToGame = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        buttonToGame.backgroundColor = UIColor.init(named: "materialGreen")
        buttonToGame.heightAnchor.constraint(equalToConstant: 75).isActive = true
        buttonToGame.widthAnchor.constraint(equalToConstant: 150).isActive = true
        buttonToGame.layer.cornerRadius = 10
        buttonToGame.setTitle("К игре", for: .normal)
        buttonToGame.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        
        let buttonToRules = UIButton(frame: CGRect(x: 100, y: 175, width: 100, height: 50))
        buttonToRules.backgroundColor = UIColor.init(named: "materialGreen")
        buttonToRules.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonToRules.widthAnchor.constraint(equalToConstant: 150).isActive = true
        buttonToRules.setTitle("Правила", for: .normal)
        buttonToRules.layer.cornerRadius = 10
        buttonToRules.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        stack.addArrangedSubview(buttonToGame)
        stack.addArrangedSubview(buttonToRules)
    }
    
}

