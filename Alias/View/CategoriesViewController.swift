//
//  CategoriesViewController.swift
//  Alias
//
//  Created by Кирилл on 27.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white 
        buttonInit()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Categories Page"
    }
    
    func buttonInit() {
          let buttonToSettings = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
          buttonToSettings.backgroundColor = UIColor.init(named: "materialGreen")
          buttonToSettings.layer.cornerRadius = 10
          buttonToSettings.setTitle("Настроить игру", for: .normal)
          buttonToSettings.addTarget(self, action: #selector(onBtnToSettingsTap), for: .touchDown)
        
        view.addSubview(buttonToSettings)
    }
    
    @objc func onBtnToSettingsTap(sender: UIButton!) {
        self.navigationController?.pushViewController(SettingsViewController(), animated: true)
    }    
}
