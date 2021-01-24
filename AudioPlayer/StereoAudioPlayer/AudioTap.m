//
//  AudioTap.m
//
//
//  Created by Alex Kovalov on 23.01.2021.
//  Copyright © 2021 . All rights reserved.
//

#import "AudioTap.h"
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@implementation AudioTap

@synthesize leftLevel;
@synthesize rightLevel;
@synthesize monoLeft;
@synthesize monoRight;

- (instancetype)init
{
    self = [super init];
    if (self) {
        leftLevel = 1;
        rightLevel = 1;
        monoLeft = false;
        monoRight = false;
    }
    return self;
}

- (MTAudioProcessingTapCallbacks)callbacks {
    
    MTAudioProcessingTapCallbacks callbacks;
    callbacks.version = kMTAudioProcessingTapCallbacksVersion_0;
    callbacks.clientInfo = (__bridge void *)(self);
    callbacks.init = init;
    callbacks.prepare = prepare;
    callbacks.process = process;
    callbacks.unprepare = unprepare;
    callbacks.finalize = finalize;
    
    return callbacks;
}

void init(MTAudioProcessingTapRef tap, void *clientInfo, void **tapStorageOut)
{
    NSLog(@"Initialising the Audio Tap Processor");
    *tapStorageOut = clientInfo;
}

void finalize(MTAudioProcessingTapRef tap)
{
    NSLog(@"Finalizing the Audio Tap Processor");
}

void prepare(MTAudioProcessingTapRef tap, CMItemCount maxFrames, const AudioStreamBasicDescription *processingFormat)
{
    NSLog(@"Preparing the Audio Tap Processor");
}

void unprepare(MTAudioProcessingTapRef tap)
{
    NSLog(@"Unpreparing the Audio Tap Processor");
}

void process(MTAudioProcessingTapRef tap,
             CMItemCount numberFrames,
             MTAudioProcessingTapFlags flags,
             AudioBufferList *bufferListInOut,
             CMItemCount *numberFramesOut,
             MTAudioProcessingTapFlags *flagsOut)
{
    OSStatus status;
    status = MTAudioProcessingTapGetSourceAudio(tap, numberFrames, bufferListInOut, flagsOut, NULL, numberFramesOut);
    
    AudioTap *context = (__bridge AudioTap *)MTAudioProcessingTapGetStorage(tap);
    
    float *bufferL = (float*)bufferListInOut->mBuffers[0].mData;
    float *bufferR = (float*)bufferListInOut->mBuffers[1].mData;
    
    for (int j=0; j<*numberFramesOut; j++)
    {
        bufferL[j] = bufferL[j] * context.leftLevel;
        bufferR[j] = bufferR[j] * context.rightLevel;
        
        if (context.monoLeft)
        {
            bufferR[j] = bufferL[j];
        }
        else if(context.monoRight)
        {
            bufferL[j] = bufferR[j];
        }
    }
}

@end
