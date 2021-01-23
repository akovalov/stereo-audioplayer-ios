//
//  AVAssetTrack+IsStereo.swift
//
//
//  Created by Alex Kovalov on 23.01.2021.
//  Copyright © 2021 . All rights reserved.
//

import AVFoundation

extension AVAssetTrack {
    
    var isStereo: Bool {
        
        for item in (formatDescriptions as? [CMAudioFormatDescription]) ?? [] {
            
            let basic = CMAudioFormatDescriptionGetStreamBasicDescription(item)
            let numberOfChannels = basic?.pointee.mChannelsPerFrame ?? 0
            
            if numberOfChannels == 2 {
                return true
            }
        }
        return false
    }
}
