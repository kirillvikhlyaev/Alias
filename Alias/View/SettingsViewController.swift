//
//  SettingsViewController.swift
//  Alias
//
//  Created by Кирилл on 27.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buttonInit()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Settings Page"
    }
    
    func buttonInit() {
        let buttonToGame = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        buttonToGame.backgroundColor = UIColor.init(named: "materialGreen")
        buttonToGame.layer.cornerRadius = 10
        buttonToGame.setTitle("К игре", for: .normal)
        buttonToGame.addTarget(self, action: #selector(onBtnToGameTap), for: .touchDown)
        
        view.addSubview(buttonToGame)
    }
    
    @objc func onBtnToGameTap() {
        self.navigationController?.pushViewController(GameViewController(), animated: true)
    }
}
