//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Vitor Capretz on 2020-03-28.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var settingsLabel: UILabel!
    
    var totalResult: Float?
    var numberOfPeople: String?
    var tipPercentage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsLabel.text = "Split between \(numberOfPeople ?? "0.0") people, with \(tipPercentage ?? "10")% tip"
        totalLabel.text = String(format: "%.2f", totalResult ?? 0.0)
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
