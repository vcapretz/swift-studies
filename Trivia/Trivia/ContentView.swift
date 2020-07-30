//
//  ContentView.swift
//  Trivia
//
//  Created by Vitor Capretz on 2020-07-21.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var quizBrain = QuizBrain()
    
    var answers: [String] {
        let answerChoices = quizBrain.getAnswers()
        
        return answerChoices
    }
    
    @State private var pressed = false
    @State private var userGotItRight = false
    @State private var selectedAnswer = ""
    
    var body: some View {
        VStack {
            Text(quizBrain.getQuestionText())
                .multilineTextAlignment(.center)
                .font(.title)
                .padding(.top)
            
            Spacer()
            
            Image(quizBrain.getQuestionCategory())
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Spacer()
            
            ForEach(answers, id: \.self) { answer in
                AnswerButton(answer: answer, correctAnswer: self.quizBrain.getCorrectAnswer(), selectedAnswer: self.$selectedAnswer, pressed: self.$pressed, userGotItRight: self.$userGotItRight)
                    .onTapGesture {
                            self.pressed.toggle()
                            self.selectedAnswer = answer
                            self.userGotItRight = self.quizBrain.checkAnswer(userAnswer: answer)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.pressed = false
                                self.userGotItRight = false
                                self.selectedAnswer = ""
                                self.quizBrain.nextQuestion()
                            }
                        }
            }
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AnswerButton: View {
    var answer: String
    var correctAnswer: String
    
    @Binding var selectedAnswer: String
    @Binding var pressed: Bool
    @Binding var userGotItRight: Bool
    
    var didPressThisAnswer: Bool {
        return selectedAnswer == answer
    }
    
    var body: some View {
        HStack {
            Image(systemName: userGotItRight && pressed && didPressThisAnswer ? "checkmark.circle" : !userGotItRight && pressed && didPressThisAnswer ? "multiply.circle" : "circle")
                .font(.system(size: 24, weight: .light))
                .foregroundColor(userGotItRight && pressed && didPressThisAnswer ? .green : !userGotItRight && pressed && didPressThisAnswer ? .red : .gray)
            
            Text(answer)
                .font(.headline)
                .foregroundColor(userGotItRight && pressed && didPressThisAnswer ? .green : !userGotItRight && pressed && didPressThisAnswer ? .red : .none)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            userGotItRight && pressed && didPressThisAnswer
                ? Color.green.opacity(0.1)
                : !userGotItRight && pressed && didPressThisAnswer
                ? Color.red.opacity(0.1)
                : Color.clear
        )
            
            .overlay(
                !userGotItRight && pressed && !didPressThisAnswer && answer == correctAnswer ?
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.green, lineWidth: 1)
                    : nil
        )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .animation(Animation.easeInOut.repeatCount(5).speed(4))
        
    }
}
