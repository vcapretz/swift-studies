//
//  MasterView.swift
//  InstagramSwiftUI
//
//  Created by Vitor Capretz on 2020-05-24.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI

struct MasterView: View {
    @ObservedObject var model: MasterViewModel
    
    var body: some View {
        Group {
            if !model.hasUserSession {
                LoginView()
            } else {
                ContentView()
            }
        }
    }
}

struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        MasterView(model: .init(userSessionService: .init()))
    }
}
