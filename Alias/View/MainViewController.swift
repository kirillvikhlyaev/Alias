//
//  ViewController.swift
//  Alias
//
//  Created by Кирилл on 26.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let stack: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 15
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stack)
        buttonsInit()
        initStackConstraints()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func onBtnToCategoriesTap(sender: UIButton!) {
        self.navigationController?.pushViewController(CategoriesViewController(), animated: true)
    }
    
    @objc func onBtnToRulesTap(sender: UIButton!) {
        self.navigationController?.pushViewController(RulesViewController(), animated: true)
    }
    
    func initStackConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant:  +100),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: +20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func buttonsInit() {
        let buttonToCategories = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        buttonToCategories.backgroundColor = UIColor.init(named: "materialGreen")
        buttonToCategories.layer.cornerRadius = 10
        buttonToCategories.setTitle("Выбрать категорию", for: .normal)
        buttonToCategories.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        buttonToCategories.addTarget(self, action: #selector(onBtnToCategoriesTap), for: .touchDown)
        
        
        let buttonToRules = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        buttonToRules.backgroundColor = UIColor.init(named: "materialGreen")
        buttonToRules.setTitle("Правила", for: .normal)
        buttonToRules.layer.cornerRadius = 10
        buttonToRules.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        buttonToRules.addTarget(self, action: #selector(onBtnToRulesTap), for: .touchUpInside)
        
        stack.addArrangedSubview(buttonToCategories)
        stack.addArrangedSubview(buttonToRules)
    }
    
}

