//
//  RulesViewController.swift
//  Alias
//
//  Created by Кирилл on 27.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import UIKit

class RulesView: UIViewController {
    
    let lbl = UILabel(frame: CGRect(x: 26, y: 81, width: 361, height: 755))
    
    var ruleHandler = RulesHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        newImage()
        textRules()
        nextClick()
        
        ruleHandler.delegate = self
        ruleHandler.getRule(0)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Rules Page"
    }
    
    @objc func buttonAction(sender: UIButton!) {
        ruleHandler.onNextRuleTap()
        print("prlfpr")
    }
}
// MARK: - RulesHandlerDelegate Section
extension RulesView: RulesHandlerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateCategories(_ rulesHandler: RulesHandler, rule: String) {
        print(rule)
        DispatchQueue.main.async {
            self.lbl.text = rule
        }
    }
}
// MARK: - View setup

extension RulesView {
    
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
    func newImage () {
        let imageName = "NewImage.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 26, y: 81, width: 361, height: 755)
        imageView.alpha = 0.4
        view.addSubview(imageView)
    }
    
    func textRules () {
        lbl.textAlignment = .center //For center alignment
        lbl.text = "Ознакомтесь с правилами"
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.lineBreakMode = .byCharWrapping
        
        
        self.view.addSubview(lbl)
    }
    
    func nextClick () {
        let nextBotton = UIButton(frame: CGRect(x: 144.5, y: 821, width: 125, height: 50))
        nextBotton.backgroundColor = K.Colors.buttonsColor
        nextBotton.setTitle("Далее", for: .normal)
        nextBotton.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
        nextBotton.layer.cornerRadius = 25
        nextBotton.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        nextBotton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        view.addSubview(nextBotton)
    }
}
