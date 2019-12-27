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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button1.layer.borderWidth = 1
        
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderWidth = 1
        
        button3.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderWidth = 1
        
        askQuestion()
    }

    func askQuestion() {
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }
}

