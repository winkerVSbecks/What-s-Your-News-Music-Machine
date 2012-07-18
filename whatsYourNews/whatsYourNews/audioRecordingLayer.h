//
//  audioRecordingLayer.h
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-06-17.
//  Copyright 2012 winkerVSbecks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "cocos2d.h"
#import "GameManager.h"

@interface audioRecordingLayer : CCLayer <AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    AVAudioPlayer *player;
	AVAudioRecorder *recorder;
	AVAudioSession *audioSession;
	NSString *destinationString;
    
    bool continueToNextScene;
    bool startRecording;
    
    CCSpriteBatchNode *sceneSpriteBatchNode;
    
    CCAnimation *giAntIntroAnimation;
    CCAnimation *giAntTalkAnimation;
    
    CCSprite *giAnt;
    
    CCProgressTimer *timer;
    float time;
    float loadTicker;
}

-(void) startRecord;
-(void) stopRecord;
-(void) playRecord;
-(void) initRecord;
-(void) checkMic;

@property (nonatomic, retain)NSString *destinationString;
@property(nonatomic, readwrite)bool continueToNextScene; 
@property(nonatomic, readwrite)bool startRecording;
@property(nonatomic, retain)CCAnimation *giAntIntroAnimation;
@property(nonatomic, retain)CCAnimation *giAntTalkAnimation;
@property(nonatomic, retain)CCSprite *giAnt;
@property (nonatomic,readwrite) float time;
@property (nonatomic,readwrite) float loadTicker;

- (NSString*) documentsPath;
- (NSString *)getUniqueFilenameInFolder:(NSString *)folder forFileExtension:(NSString *)fileExtension;

@end
