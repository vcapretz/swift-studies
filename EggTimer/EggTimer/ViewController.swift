//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player: AVAudioPlayer!
    
    let eggTimes = [
        "Soft": 5, //* 60,
        "Medium": 7 * 60,
        "Hard": 12 * 60
    ]
    
    var totalTime = 0
    var secondsPassed = 0
    var timer: Timer?
    
    @IBOutlet var progressBar: UIProgressView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = "How do you like your eggs?"
        
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)

    }
    
    @objc func updateCounter(initialCount: Int) {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            self.timer?.invalidate()
            titleLabel.text = "Done!"
            
            playAlarm()
        }
    }
    

    func playAlarm(){
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
