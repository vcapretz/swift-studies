//
//  Mission.swift
//  Moonshot
//
//  Created by Vitor Capretz on 2020-07-27.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let crew: [CrewRole]
    let description: String
    let launchDate: Date?
    
    var displayName: String {
        return "Apollo \(id)"
    }
    
    var image: String {
        return "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        guard let launchDate = launchDate else { return "N/A" }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        
        return formatter.string(from: launchDate)
    }
}
