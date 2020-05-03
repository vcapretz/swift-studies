//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet var billTextField: UITextField!
    @IBOutlet var zeroPctButton: UIButton!
    @IBOutlet var tenPctButton: UIButton!
    @IBOutlet var twentyPctButton: UIButton!
    @IBOutlet var splitNumberLabel: UILabel!
    
    var tipValue: Float = 0.0
    var totalResult: Float = 0.0
    
    func clearAllButtons() {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        clearAllButtons()
        
        sender.isSelected = true
        let tipText = sender.titleLabel?.text ?? "0%"
        
        if tipText == "10%" {
            tipValue = 0.1
        } else if tipText == "20%" {
            tipValue = 0.2
        }
        
        billTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(Int(sender.value))
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let numberOfPeople = Float(splitNumberLabel.text ?? "1.0")!
        
        if let amountTyped = Float(billTextField.text ?? "0.0") {
            totalResult = amountTyped * (1 + tipValue) / numberOfPeople
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            
            destinationVC.numberOfPeople = splitNumberLabel.text
            destinationVC.tipPercentage = String(format: "%.0f", tipValue * 100)
            destinationVC.totalResult = totalResult
//            destinationVC.bmiValue = calculatorBrain.getBMIValue()
//            destinationVC.advice = calculatorBrain.getAdvice()
//            destinationVC.color = calculatorBrain.getColor()
        }
    }
}

