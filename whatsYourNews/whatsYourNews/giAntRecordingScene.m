//
//  giAntRecordingScene.m
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-05-29.
//  Copyright 2012 winkerVSbecks. All rights reserved.
//
#import "giAntRecordingScene.h"

@implementation giAntRecordingScene

-(id)init 
{
    self = [super init];
    if (self != nil) 
    { 
        // Interactive Layer: Musical Ants, Musical Object, etc
        audioRecordingLayer *voiceRecorderLayer = [audioRecordingLayer node]; 
        [self addChild:voiceRecorderLayer z:2];                       
    }
    return self;
}

@end
