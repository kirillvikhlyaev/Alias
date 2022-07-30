//
//  JokeRequest.swift
//  Alias
//
//  Created by Сергей Юдин on 29.07.2022.
//  Copyright © 2022 Kirill. All rights reserved.
//

import Foundation

class JokeRequest {
    
    func request(completion: @escaping (JokeModel) -> Void) {
        let url = URL(string: "https://joke.deno.dev/")
        let task = URLSession.shared.dataTask(with: url!) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let joke = try JSONDecoder().decode(JokeModel.self, from: data)
                completion(joke)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
