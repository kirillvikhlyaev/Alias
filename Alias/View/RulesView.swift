//
//  RulesViewController.swift
//  Alias
//
//  Created by Кирилл on 27.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import UIKit

class RulesView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Rules Page"
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
}
