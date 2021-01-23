//
//  StereoAudioPlayer.swift
//
//
//  Created by Alex Kovalov on 23.01.2021.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import AVFoundation

class StereoAudioPlayer: AudioPlayable {
    
    var currentTime: TimeInterval {
        set {
            player.seek(to: CMTime(seconds: newValue, preferredTimescale: 1))
        }
        get {
            return player.currentTime().seconds
        }
    }
    var duration: TimeInterval {
        return player.currentItem?.asset.duration.seconds ?? 0
    }
    var isPlaying: Bool {
        return player.rate != 0 && player.error == nil
    }
    var onDidFinishPlaying: ((_ successfully: Bool) -> Void)?
    
    var leftLevel: Float = 1 {
        didSet {
            audioTap.leftLevel = leftLevel
        }
    }
    var rightLevel: Float = 1 {
        didSet {
            audioTap.rightLevel = rightLevel
        }
    }
    
    private var player: AVPlayer!
    private var audioTap: AudioTap!
        
    required init(contentsOf url: URL) {
        
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        
        audioTap = AudioTap()
        var callbacks = audioTap.callbacks()
        
        var tap: Unmanaged<MTAudioProcessingTap>?
        MTAudioProcessingTapCreate(kCFAllocatorDefault, &callbacks, kMTAudioProcessingTapCreationFlag_PreEffects, &tap)
        
        let track = asset.tracks[0]
        let params = AVMutableAudioMixInputParameters(track: track)
        params.audioTapProcessor = tap?.takeUnretainedValue()
        
        let audioMix = AVMutableAudioMix()
        audioMix.inputParameters = [params]
        playerItem.audioMix = audioMix
        
        player = AVPlayer(playerItem: playerItem)
        
        NotificationCenter.default.addObserver(self, selector: #selector(itemDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    }
    
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    @objc
    private func itemDidFinishPlaying() {
        onDidFinishPlaying?(true)
    }
}
