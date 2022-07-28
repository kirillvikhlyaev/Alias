//
//  SettingsViewController.swift
//  Alias
//
//  Created by Кирилл on 27.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import UIKit

class SettingsView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        buttonInit()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Settings Page"
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
    
    func buttonInit() {
        let buttonToGame = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        buttonToGame.backgroundColor = UIColor.init(named: "buttonsColor")
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
    
    @objc func onBtnToGameTap() {
        self.navigationController?.pushViewController(GameViewController(), animated: true)
    }
}
