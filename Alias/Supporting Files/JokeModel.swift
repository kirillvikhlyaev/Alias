//
//  JokeModel.swift
//  Alias
//
//  Created by Сергей Юдин on 29.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import Foundation

// MARK: - JokeModel
struct JokeModel: Codable {
    let id: Int
    let type, setup, punchline: String
}
