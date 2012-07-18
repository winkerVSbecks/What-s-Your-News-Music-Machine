//
//  interactiveLayer.h
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-06-07.
//  Copyright 2012 winkerVSbecks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CommonProtocols.h"
#import "GameManager.h"
#import "SimpleAudioEngine.h"

#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface interactiveLayer : CCLayer <GameplayLayerDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    CCSpriteBatchNode *sceneSpriteBatchNode;
    CCSpriteBatchNode *triggersSpriteBatchNode;
    CCSpriteBatchNode *triggersSpriteBatchNodeTwo;
    
    AVAudioPlayer *player;
    AVAudioSession *audioSession;
}

-(void) triggerChildVoice;

-(void)switchSceneAndCleanup;

+(CGPoint) locationFromTouch:(UITouch*)touch;
+(CGPoint) locationFromTouches:(NSSet *)touches;

@end