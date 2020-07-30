//
//  Data.swift
//  DesingCode1
//
//  Created by Vitor Capretz on 2020-07-12.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI

struct Post: Codable, Identifiable {
    let id = UUID().uuidString
    var title: String
    var body: String
}

class Api {
    func getPosts(completion: @escaping ([Post]) -> ()){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return     }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let safeData = data {
                let posts = try! JSONDecoder().decode([Post].self, from: safeData)
                
                DispatchQueue.main.async {
                    completion(posts)
                }
            }
        }
        .resume()
    }
}
