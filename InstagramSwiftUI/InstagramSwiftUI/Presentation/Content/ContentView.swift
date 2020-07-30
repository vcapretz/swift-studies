//
//  ContentView.swift
//  InstagramSwiftUI
//
//  Created by Vitor Capretz on 2020-05-24.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userSessionService: UserSessionService
    
    var body: some View {
        VStack(spacing: 4) {
            Text("Hello, \(userSessionService.session?.user.name ?? "")")
            
            Button(action: userSessionService.logout) {
                Text("Tap to log out")
            }
            
            Button(action: { self.userSessionService.updateUserName("Vitor") }) {
                Text("Tap to update name")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
