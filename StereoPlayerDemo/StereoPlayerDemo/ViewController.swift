//
//  ViewController.swift
//  StereoPlayerDemo
//
//  Created by Alex Kovalov on 23.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var leftSlider: UISlider!
    @IBOutlet weak var rightSlider: UISlider!
    @IBOutlet weak var monoButton: UIButton!
    
    var player: AudioPlayable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlayer()
    }
    
    func setupPlayer() {
        
        let url = Bundle.main.url(forResource: "stereo-test", withExtension: "mp3")!
        
        if AVAsset(url: url).tracks.first?.isStereo == true {
            player = StereoAudioPlayer(contentsOf: url)
            leftSlider.value = (player as? StereoAudioPlayer)?.leftLevel ?? 0
            rightSlider.value = (player as? StereoAudioPlayer)?.rightLevel ?? 0
        } else {
            player = SimpleAudioPlayer(contentsOf: url)
        }
    }
    
    @IBAction func play(_ sender: UIButton) {
        
        player?.currentTime = 0
        player?.play()
    }
    
    @IBAction func leftValueChanged(_ sender: UISlider) {
        
        (player as? StereoAudioPlayer)?.leftLevel = sender.value
    }
    
    @IBAction func rightValueChanged(_ sender: UISlider) {
        
        (player as? StereoAudioPlayer)?.rightLevel = sender.value
    }
    
    @IBAction func monoToggle(_ sender: UIButton) {
        
        monoButton.isSelected = !monoButton.isSelected
        monoButton.setTitle(monoButton.isSelected ? "Stereo" : "Mono", for: .normal)
        
        (player as? StereoAudioPlayer)?.mono = monoButton.isSelected
    }
}

