//
//  GameViewController.swift
//  Alias
//
//  Created by Кирилл on 27.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import UIKit

class GameView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        
        // На этапе релиза - убрать
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Game Page"
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
}
