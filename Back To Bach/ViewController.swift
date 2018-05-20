//
//  ViewController.swift
//  Back To Bach
//
//  Created by Steven Lerner on 5/20/18.
//  Copyright © 2018 Steven Lerner. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    let audioPath = Bundle.main.path(forResource: "sheep", ofType: "mp3")
    var timer = Timer()
    
    @objc func updateScrubber() {
        
        if player.isPlaying {
        
            scrubber.value = Float(player.currentTime)
            
        } else {
            
            timer.invalidate()
            scrubber.value = 0
            
        }
        
    }
    
    @IBOutlet var volumeSlider: UISlider!
    @IBOutlet var scrubber: UISlider!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            
            scrubber.maximumValue = Float(player.duration)
            
        } catch {
            
            // process error
            
        }
        
    }

    @IBAction func playTapped(_ sender: Any) {
        
        player.play()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateScrubber), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func volumeChanged(_ sender: Any) {
        
        player.volume = volumeSlider.value
        
    }
    
    @IBAction func scrubberChanged(_ sender: Any) {
        
        player.currentTime = TimeInterval(scrubber.value)
        
    }
    
    @IBAction func stopTapped(_ sender: Any) {
        
        scrubber.value = 0
        
        timer.invalidate()
        
        player.pause()
        
        do {
            
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            
        } catch {
            
            // process error
            
        }
        
    }
    
    @IBAction func pauseTapped(_ sender: Any) {
        
        player.pause()
        
        timer.invalidate()
        
    }
    
}

