//
//  ViewController.swift
//  Alias
//
//  Created by Кирилл on 26.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import UIKit

class MainView: UIViewController {
    
    let stack: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 25
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        setMainIcon()
        view.addSubview(stack)
        buttonsInit()
        initStackConstraints()
    }
    
    func setBackground() {
        let backgroindImage = UIImage(named: "backgroundImage")
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = backgroindImage
        imageView.center = view.center
        
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func setMainIcon() {
        let mainIcon = UIImage(named: "mainIcon")
        let imageView = UIImageView(image: mainIcon)
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.center = view.center
        
        view.addSubview(imageView)
    }
    
    func initStackConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant:  +175),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: +40),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
    }
    
    func buttonsInit() {
        let buttonToCategories = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        buttonToCategories.backgroundColor = UIColor.init(named: "buttonsColor")
        buttonToCategories.layer.cornerRadius = 25
        buttonToCategories.setTitle("К игре", for: .normal)
        buttonToCategories.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
        buttonToCategories.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        buttonToCategories.addTarget(self, action: #selector(onBtnToCategoriesTap), for: .touchDown)
        
        
        let buttonToRules = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        buttonToRules.backgroundColor = UIColor.init(named: "buttonsColor")
        buttonToRules.setTitle("Правила", for: .normal)
        buttonToRules.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
        buttonToRules.layer.cornerRadius = 25
        buttonToRules.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        buttonToRules.addTarget(self, action: #selector(onBtnToRulesTap), for: .touchUpInside)
        
        stack.addArrangedSubview(buttonToCategories)
        stack.addArrangedSubview(buttonToRules)
    }
    
    @objc func onBtnToCategoriesTap(sender: UIButton!) {
        self.navigationController?.pushViewController(CategoriesView(), animated: true)
    }
    
    @objc func onBtnToRulesTap(sender: UIButton!) {
        self.navigationController?.pushViewController(RulesView(), animated: true)
    }
}

