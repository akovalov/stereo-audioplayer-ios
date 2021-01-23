//
//  SimpleAudioPlayer.swift
//
//
//  Created by Alex Kovalov on 23.01.2021.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import AVFoundation

class SimpleAudioPlayer: NSObject, AudioPlayable {
    
    var currentTime: TimeInterval {
        set {
            player?.currentTime = newValue
        }
        get {
            return player?.currentTime ?? 0
        }
    }
    var duration: TimeInterval {
        return player?.duration ?? 0
    }
    var onDidFinishPlaying: ((_ successfully: Bool) -> Void)?
    var isPlaying: Bool {
        return player?.isPlaying ?? false
    }
    
    private var player: AVAudioPlayer?
    
    required init(contentsOf url: URL) {
        super.init()
        
        player = try? AVAudioPlayer(contentsOf: url)
        player?.delegate = self
        player?.prepareToPlay()
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
}

// MARK: AVAudioPlayerDelegate

extension SimpleAudioPlayer: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        onDidFinishPlaying?(flag)
    }
}
