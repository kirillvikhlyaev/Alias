//
//  TeamCell.swift
//  Alias
//
//  Created by Сергей Цайбель on 02.08.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import UIKit

class TeamCell: UITableViewCell {

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 10))

		contentView.addSubview(label)
		
		NSLayoutConstraint.activate([
			label.topAnchor.constraint(equalTo: contentView.topAnchor),
			label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		self.selectionStyle = .none
	}
	
	func setupCell(_ teamName: String) {
		label.text = teamName
	}
	
	let label: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.numberOfLines = 2
		label.textAlignment = .center
		label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
