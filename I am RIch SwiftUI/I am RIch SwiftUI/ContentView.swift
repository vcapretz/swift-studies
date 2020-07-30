//
//  ContentView.swift
//  I am RIch SwiftUI
//
//  Created by Vitor Capretz on 2020-05-09.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.systemTeal).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("I am Rich!")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .bold()
                
                Image("diamond")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200, alignment: .center)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
