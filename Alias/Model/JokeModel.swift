//
//  JokeModel.swift
//  Alias
//
//  Created by Кирилл on 30.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import Foundation

// JokeModel
struct JokeModel: Codable {
    let id: Int
    let type, setup, punchline: String
}
