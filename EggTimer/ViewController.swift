//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {

    //    let eggTimes = [
    //        "Soft": 300,
    //        "Medium": 420,
    //        "Hard": 720,
    //    ]
    var player: AVAudioPlayer!

    let eggTimes: [String: Int] = [
        "Soft": 3,
        "Medium": 4,
        "Hard": 7,
    ]

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!

    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()

    @IBAction func hardnessSelected(_ sender: UIButton) {

        let hardness = sender.currentTitle!

        progressBar.progress = 0
        timer.invalidate()
        secondsPassed = 0
        titleLabel.text = hardness

        totalTime = eggTimes[hardness]!

        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )

    }

    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            titleLabel.text = "Done!"
            playAlarm()
        }

    }

    func playAlarm() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }

}
