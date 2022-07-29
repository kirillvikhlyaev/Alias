//
//  CategoryTableViewCell.swift
//  Alias
//
//  Created by Кирилл on 29.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    var title = UILabel()
    var emoji = UILabel()
    var desc = UILabel()
    
    let verticalStack: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 20
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    let horizontalStack: UIStackView = {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 20
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Set any attributes of your UI components here.
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 20)
        
        // Add the UI components
        verticalStack.addArrangedSubview(title)
        verticalStack.addArrangedSubview(desc)
        horizontalStack.addArrangedSubview(verticalStack)
        horizontalStack.addArrangedSubview(emoji)
        contentView.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        contentView.addSubview(horizontalStack)
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 10))
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
