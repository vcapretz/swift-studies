//
//  ViewController.swift
//  Project2
//
//  Created by Vitor Capretz on 2019-12-27.
//  Copyright © 2019 Vitor Capretz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var score = 0
    var countries = [String]()
    var correctAnswer = 0
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button1.layer.borderWidth = 1
        button1.tag = 0
        
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderWidth = 1
        button2.tag = 1
        
        button3.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderWidth = 1
        button3.tag = 2
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()): \(score)"
        questionsAsked += 1
        
        if questionsAsked == 11 {
            questionsAsked = 0
            score = 0
            
            let ac = UIAlertController(title: "Game ended", message: "Total score: \(score)", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "New game", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        
        if sender.tag == correctAnswer {
            title = "Correct!"
            score += 1
            
            message = "Your score is \(score)"
        } else {
            title = "Wrong..."
            score -= 1
            
            message = "Wrong, that was the flag for \(countries[sender.tag].uppercased())"
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
    }
    
}

