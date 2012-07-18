//
//  GameManager.h
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-06-15.
//  Copyright (c) 2012 winkerVSbecks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonProtocols.h"
#import "SimpleAudioEngine.h"

@interface GameManager : NSObject <CDLongAudioSourceDelegate> {
    BOOL isMusicON;
    BOOL isSoundEffectsON;
    BOOL hasPlayerDied;
    SceneTypes currentScene;
    
    // Added for audio
    BOOL hasAudioBeenInitialized;
    GameManagerSoundState managerSoundState;
    SimpleAudioEngine *soundEngine;
    NSMutableDictionary *listOfSoundEffectFiles;
    NSMutableDictionary *soundEffectsState;
    
    SceneTypes curLevel;
    SceneTypes lastLevel;
    
    CDLongAudioSource *beatBox;
    CDLongAudioSource *maleLow;
    CDLongAudioSource *humanTrumpets;
    CDLongAudioSource *femaleGroup;
    CDLongAudioSource *beeps;
    
    CDLongAudioSource *recordedVoice;
    
    bool didStartThemeSong;
    
    bool isMusicGameDone;
    bool runningAudioMixerFirstTime;
    
    NSURL *destinationURL;
    NSString *audioFileName;
    NSString *pathOfImage;
}
@property (readwrite) BOOL isMusicON;
@property (readwrite) BOOL isSoundEffectsON;
@property (readwrite) BOOL hasPlayerDied;
@property (readwrite) GameManagerSoundState managerSoundState;
@property (readonly) SimpleAudioEngine *soundEngine;
@property (nonatomic, retain) NSMutableDictionary *listOfSoundEffectFiles;
@property (nonatomic, retain) NSMutableDictionary *soundEffectsState;
@property (assign) SceneTypes curLevel;
@property (assign) SceneTypes lastLevel;

@property (nonatomic, readwrite)bool isMusicGameDone;

@property (nonatomic, retain) CDLongAudioSource *beatBox;
@property (nonatomic, retain) CDLongAudioSource *maleLow;
@property (nonatomic, retain) CDLongAudioSource *humanTrumpets;
@property (nonatomic, retain) CDLongAudioSource *femaleGroup;
@property (nonatomic, retain) CDLongAudioSource *beeps;

@property (nonatomic, retain) CDLongAudioSource *backgroundAudioSnnipets;

@property (nonatomic, readwrite) bool didStartThemeSong;
@property (nonatomic, readwrite)bool runningAudioMixerFirstTime;

@property (nonatomic, retain)NSURL *destinationURL;
@property (nonatomic, retain)NSString *audioFileName;
@property (nonatomic, retain)NSString *pathOfImage;

+(GameManager*)sharedGameManager;                                

-(void)runSceneWithID:(SceneTypes)sceneID;                         

-(void)openSiteWithLinkType:(LinkTypes)linkTypeToOpen ;           

-(void)initAudioForMixer;
-(void)playAudio;
-(void)pauseAllAudio;
-(void)resumeAllAudio;
-(void)stopAllAudio;

-(void)setupAudioEngine;
-(ALuint)playSoundEffect:(NSString*)soundEffectKey;
-(void)stopSoundEffect:(ALuint)soundEffectID;
-(void)playBackgroundTrack:(NSString*)trackFileName;

@end
