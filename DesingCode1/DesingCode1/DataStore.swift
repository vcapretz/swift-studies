//
//  DataStore.swift
//  DesingCode1
//
//  Created by Vitor Capretz on 2020-07-12.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import Foundation
import Combine

class DataStore: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        Api().getPosts { (posts) in
            self.posts = posts
        }
    }
}
