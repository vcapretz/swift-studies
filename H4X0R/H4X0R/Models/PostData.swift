//
//  PostData.swift
//  H4X0R
//
//  Created by Vitor Capretz on 2020-05-10.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}
