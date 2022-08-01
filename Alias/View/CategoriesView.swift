//
//  CategoriesViewController.swift
//  Alias
//
//  Created by Кирилл on 27.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import UIKit

class CategoriesView: UIViewController {
    
    var myTableView: UITableView!
    var categories: [CategoryData] = []
    var categoriesHandler = CategoriesHandler()
    
    let dest = SettingsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        
        categoriesHandler.delegate = self
        categoriesHandler.getCategories()
        
        self.title = "Categories Page"
        
    }
    
}
// MARK: - DataHandlerDelegate

extension CategoriesView: CategoriesHandlerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateCategories(_ categoriesHandler: CategoriesHandler, categories: [CategoryData]) {
        self.categories = categories
        myTableView.reloadData()
    }
}
// MARK: - TableView Section

extension CategoriesView: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 8
        let horizontalPadding: CGFloat = 8
        
        let maskLayer = CALayer()
        maskLayer.cornerRadius = 25    //if you want round edges
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: horizontalPadding, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.navigationController?.pushViewController(SettingsView(chosenCategoryIndex: indexPath.row), animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Strings.reusCellID, for: indexPath) as! CategoryTableViewCell
        
        cell.desc.text = categories[indexPath.row].description
        
        cell.emoji.text = categories[indexPath.row].emoji
        
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: categories[indexPath.row].name, attributes: underlineAttribute)
        cell.title.attributedText = underlineAttributedString
        
        return cell
    }
}

// MARK: - View Setup

extension CategoriesView {
    func setupTable() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: K.Strings.reusCellID)
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.separatorStyle = .none
        
        let backgroindImage = UIImage(named: K.Strings.backgroundImage)
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = backgroindImage
        imageView.center = view.center
        
        myTableView.backgroundView = imageView
        
        self.view.addSubview(myTableView)
    }
}
