//
//  ContentView.swift
//  Challenge1-HWS
//
//  Created by Vitor Capretz on 2020-07-22.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let moves: [String] = ["✊🏽", "🤚🏽", "✌🏽"]
    
    @State private var currentMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    
    @State private var score = 0
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Score \(score)")
                .font(.title)
                .padding(.top)
            
            Spacer()
            
            Text("\(moves[currentMove])")
                .font(.system(size: 60))
            
            Text("Pick a move to ") +
                Text("\(shouldWin ? "win" : "lose")")
                    .bold()
            
            HStack {
                ForEach(moves.shuffled(), id: \.self) { move in
                    Button(action: {
                        let direction = self.shouldWin ? 1 : -1
                        let winnerIndex = self.currentMove + direction
                        let fixedWinnerIndex = winnerIndex == 3 ? 0 : winnerIndex == -1 ? 2 : winnerIndex
                        
                        let winnerMove = self.moves[fixedWinnerIndex]
                        
                        if winnerMove == move {
                            self.score += 1
                        }
                        
                        self.currentMove = Int.random(in: 0...2)
                        self.shouldWin = Bool.random()
                    }) {
                        Text("\(move)")
                            .font(.system(size: 50))
                    }
                        .padding()
                }
            }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
