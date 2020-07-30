//
//  ContentView.swift
//  Challenge2-HWS
//
//  Created by Vitor Capretz on 2020-07-26.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI

var questions = ["5", "10", "15", "All"]

struct Question: Identifiable {
    let id = UUID().uuidString

    var text: String
    var correctAnswer: Int
}

func getMultiples(upTo table: Int) -> [Question] {
    return (1 ... table).flatMap { tableNumber in
        return (1 ... 10).map { Question(text: "\(tableNumber) x \($0)", correctAnswer: $0 * tableNumber) }
    }
}

struct ContentView: View {
    @State private var isPlayingGame = false
    @State private var isGameFinished = false
    
    @State private var selectedMultiple: CGFloat = 4
    @State private var numberOfQuestions: Int = 2
    
    @State private var currentQuestion = 0
    @State private var score = 0
    
    @State private var allQuestions: [Question] = []
    
    @State private var userAnswer: String = ""
    
    var body: some View {
        Group {
            if !isPlayingGame {
                SettingsView(isPlayingGame: $isPlayingGame, selectedMultiple: $selectedMultiple, numberOfQuestions: $numberOfQuestions, allQuestions: $allQuestions)
            } else {
                VStack {
                    Text(allQuestions[currentQuestion].text)
                        .font(.largeTitle)
                    
                    TextField("Type your answer", text: $userAnswer)
                        .keyboardType(.decimalPad)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Next") {
                        let current = self.currentQuestion
                        let maxQuestions = Int(questions[self.numberOfQuestions]) ?? self.allQuestions.count
                        
                        if current < maxQuestions {
                            
                            print("all \(self.allQuestions)")
                            print("current \(self.currentQuestion)")
                            
                            if let userAnswer = Int(self.userAnswer) {
                                if self.allQuestions[self.currentQuestion].correctAnswer == userAnswer {
                                    self.score += 1
                                }
                            }
                            
                            self.userAnswer = ""
                            self.currentQuestion += 1
                        } else {
                            self.isGameFinished = true
                        }
                    }
                    
                }
                .alert(isPresented: $isGameFinished, content: {
                    Alert(title: Text("Game over"), message: Text("Your total score was \(self.score)"), dismissButton: .default(Text("New game"), action: {
                        self.userAnswer = ""
                        self.score = 0
                        self.currentQuestion = 0
                        self.isPlayingGame = false
                        self.isGameFinished = false
                    }))
                })
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SettingsView: View {
    @Binding var isPlayingGame: Bool
    @Binding var selectedMultiple: CGFloat
    @Binding var numberOfQuestions: Int
    @Binding var allQuestions: [Question]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Multiples")) {
                    Stepper(value: $selectedMultiple, in: 1 ... 12) {
                        Text("Up to \(selectedMultiple, specifier: "%g")")
                    }
                }
                
                Section(header: Text("Number of questions")) {
                    Picker("Difficulty", selection: $numberOfQuestions) {
                        ForEach(0 ..< questions.count) { index in
                            Text(questions[index])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Button("Start Game!") {
                    self.allQuestions = getMultiples(upTo: Int(self.selectedMultiple)).shuffled()
                    self.isPlayingGame = true
                }
            }
            .navigationBarTitle(Text("Game Settings"))
        }
    }
}
