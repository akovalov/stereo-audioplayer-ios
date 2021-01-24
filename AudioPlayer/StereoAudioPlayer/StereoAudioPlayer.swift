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
            leftPlayer.seek(to: CMTime(seconds: newValue, preferredTimescale: 1))
            rightPlayer.seek(to: CMTime(seconds: newValue, preferredTimescale: 1))
        }
        get {
            return leftPlayer.currentTime().seconds
        }
    }
    var duration: TimeInterval {
        return leftPlayer.currentItem?.asset.duration.seconds ?? 0
    }
    var isPlaying: Bool {
        return leftPlayer.rate != 0 && leftPlayer.error == nil
    }
    var onDidFinishPlaying: ((_ successfully: Bool) -> Void)?
    
    var leftLevel: Float = 1 {
        didSet {
            leftAudioTap.leftLevel = leftLevel
        }
    }
    var rightLevel: Float = 1 {
        didSet {
            rightAudioTap.rightLevel = rightLevel
        }
    }
    var mono: Bool = false {
        didSet {
            leftAudioTap.monoLeft = mono;
            rightAudioTap.monoRight = mono;
        }
    }
    
    private var leftPlayer: AVPlayer!
    private var rightPlayer: AVPlayer!
    private var leftAudioTap: AudioTap!
    private var rightAudioTap: AudioTap!
        
    required init(contentsOf url: URL) {
        
        leftAudioTap = AudioTap()
        leftAudioTap.leftLevel = 1
        leftAudioTap.rightLevel = 0
        leftPlayer = setupPlayer(with: url, audioTap: leftAudioTap)
        
        rightAudioTap = AudioTap()
        rightAudioTap.leftLevel = 0
        rightAudioTap.rightLevel = 1
        rightPlayer = setupPlayer(with: url, audioTap: rightAudioTap)
        
        if let playerItem = leftPlayer.currentItem {
            NotificationCenter.default.addObserver(self, selector: #selector(itemDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        }
    }
    
    private func setupPlayer(with url: URL, audioTap: AudioTap) -> AVPlayer {
        
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        
        var callbacks = audioTap.callbacks()
        
        var tap: Unmanaged<MTAudioProcessingTap>?
        MTAudioProcessingTapCreate(kCFAllocatorDefault, &callbacks, kMTAudioProcessingTapCreationFlag_PreEffects, &tap)
        
        let track = asset.tracks[0]
        let params = AVMutableAudioMixInputParameters(track: track)
        params.audioTapProcessor = tap?.takeUnretainedValue()
        
        let audioMix = AVMutableAudioMix()
        audioMix.inputParameters = [params]
        playerItem.audioMix = audioMix
        
        return AVPlayer(playerItem: playerItem)
    }
    
    func play() {
        leftPlayer.play()
        rightPlayer.play()
    }
    
    func pause() {
        leftPlayer.pause()
        rightPlayer.pause()
    }
    
    @objc
    private func itemDidFinishPlaying() {
        onDidFinishPlaying?(true)
    }
}
