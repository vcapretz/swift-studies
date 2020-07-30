//
//  Question.swift
//  Trivia
//
//  Created by Vitor Capretz on 2020-07-22.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import Foundation

struct Question {
    let text: String
    let answers: [String]
    let rightAnswer: String
    let category: String
    
    init(q: String, a: [String], correctAnswer: String, c: String) {
        text = q
        answers = a
        rightAnswer = correctAnswer
        category = c
    }
}
