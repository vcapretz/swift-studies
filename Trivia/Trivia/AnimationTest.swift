//
//  AnimationTest.swift
//  Trivia
//
//  Created by Vitor Capretz on 2020-07-26.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI

struct AnimationTest: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("Tap me") {
            withAnimation {
                self.animationAmount += 360
            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 1))
    }
}

struct AnimationTest_Previews: PreviewProvider {
    static var previews: some View {
        AnimationTest()
    }
}
