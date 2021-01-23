//
//  AudioPlayable.swift
//
//
//  Created by Alex Kovalov on 23.01.2021.
//  Copyright © 2021 . All rights reserved.
//

import Foundation

protocol AudioPlayable {
    
    var currentTime: TimeInterval { get set }
    var duration: TimeInterval { get }
    var onDidFinishPlaying: ((_ successfully: Bool) -> Void)? { get set }
    var isPlaying: Bool { get }
    
    init(contentsOf url: URL)
    
    func play()
    func pause()
}
