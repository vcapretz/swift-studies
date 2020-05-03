//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var diceImageView1: UIImageView!
    @IBOutlet var diceImageView2: UIImageView!
    
    let dice = ["One", "Two", "Three", "Four", "Five", "Six"]
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        diceImageView1.image = UIImage(named: "Dice\(dice.randomElement()!)")
        diceImageView2.image = UIImage(named: "Dice\(dice.randomElement()!)")
    }
    
}

