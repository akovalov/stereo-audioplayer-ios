//
//  AudioTap.h
//
//
//  Created by Alex Kovalov on 23.01.2021.
//  Copyright © 2021 . All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#ifndef AudioTap_h
#define AudioTap_h

@interface AudioTap: NSObject

- (MTAudioProcessingTapCallbacks)callbacks;

@property(nonatomic, assign) float leftLevel;
@property(nonatomic, assign) float rightLevel;

@end

#endif /* AudioTap_h */
