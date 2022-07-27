//
//  CategoriesViewController.swift
//  Alias
//
//  Created by Кирилл on 27.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import UIKit

class CategoriesView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        buttonInit()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Categories Page"
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
        let buttonToSettings = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        buttonToSettings.backgroundColor = UIColor.init(named: "buttonsColor")
        buttonToSettings.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
        buttonToSettings.layer.cornerRadius = 25
        buttonToSettings.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonToSettings.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        buttonToSettings.setTitle("Настроить игру", for: .normal)
        buttonToSettings.addTarget(self, action: #selector(onBtnToSettingsTap), for: .touchDown)
        buttonToSettings.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(buttonToSettings)
        
        let leftConstraint = NSLayoutConstraint(item: buttonToSettings, attribute: .leftMargin, relatedBy: .equal, toItem: view, attribute: .leftMargin, multiplier: 1, constant: +40)
        
        let rightConstraint = NSLayoutConstraint(item: buttonToSettings, attribute: .rightMargin, relatedBy: .equal, toItem: view, attribute: .rightMargin, multiplier: 1, constant: -40)
        
        let bottomConstraint = NSLayoutConstraint(item: buttonToSettings, attribute: .bottomMargin, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1, constant: -25)
        
        view.addConstraints([leftConstraint, rightConstraint, bottomConstraint])
    }
    
    @objc func onBtnToSettingsTap(sender: UIButton!) {
        self.navigationController?.pushViewController(SettingsView(), animated: true)
    }    
}
