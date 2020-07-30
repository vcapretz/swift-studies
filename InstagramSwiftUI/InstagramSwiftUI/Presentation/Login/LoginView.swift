//
//  LoginView.swift
//  InstagramSwiftUI
//
//  Created by Vitor Capretz on 2020-05-24.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userSessionService: UserSessionService
    
    var body: some View {
        Button(action: userSessionService.login) {
            Text("Tap to login")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
