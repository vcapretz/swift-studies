//
//  NetworkManager.swift
//  H4X0R
//
//  Created by Vitor Capretz on 2020-05-10.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData() {
        guard let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let e = error {
                print(e.localizedDescription)
                return
            }
            
            let decoder = JSONDecoder()
            
            guard let safeData = data else { return }
            
            do {
                let results = try decoder.decode(Results.self, from: safeData)
                DispatchQueue.main.sync {
                    self.posts = results.hits
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
