//
//  UserSessionService.swift
//  InstagramSwiftUI
//
//  Created by Vitor Capretz on 2020-05-24.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import Foundation
import Combine

final class UserSessionService: ObservableObject {
    @Published var session: UserSession?
    
    func login() {
        session = .init(user: .init(name: "vcapretz"), token: UUID().uuidString)
    }
    
    func logout() {
        session = nil
    }
    
    func updateUserName(_ name: String) {
        session?.user.name = name
    }
}
