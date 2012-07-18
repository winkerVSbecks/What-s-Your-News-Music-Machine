//
//  GameManager.m
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-06-15.
//  Copyright (c) 2012 winkerVSbecks. All rights reserved.
//

#import "GameManager.h"
#import "audioMixerScene.h"
#import "giAntRecordingScene.h"

@implementation GameManager
static GameManager* _sharedGameManager = nil;                      
@synthesize isMusicON;
@synthesize soundEngine;
@synthesize isSoundEffectsON;
@synthesize hasPlayerDied;
@synthesize managerSoundState;
@synthesize listOfSoundEffectFiles;
@synthesize soundEffectsState;
@synthesize curLevel;
@synthesize lastLevel;
@synthesize didStartThemeSong;
@synthesize destinationURL;
@synthesize audioFileName;
@synthesize pathOfImage;
@synthesize maleLow, beatBox, humanTrumpets, femaleGroup, beeps;
@synthesize backgroundAudioSnnipets;
@synthesize isMusicGameDone;
@synthesize runningAudioMixerFirstTime;

+(GameManager*)sharedGameManager 
{
    @synchronized([GameManager class])                             
    {
        if(!_sharedGameManager)                                   
            [[self alloc] init]; 
        return _sharedGameManager;                                 
    }
    return nil; 
}

+(id)alloc 
{
    @synchronized ([GameManager class])                          
    {
        NSAssert(_sharedGameManager == nil,
                 @"Attempted to allocated a second instance of the Game Manager singleton");
        _sharedGameManager = [super alloc];
        return _sharedGameManager;                                
    }
    return nil;  
}

-(void)initAudioForMixer
{
    
    // LEFT CHANNEL IS BACKGORUND MUSIC
    
    beeps=[[CDAudioManager sharedManager] audioSourceForChannel:kASC_Right];
    beeps.delegate=self;
    
    maleLow=[[CDAudioManager sharedManager] audioSourceForChannel:kASC_Three];
    maleLow.delegate=self;
    
    humanTrumpets=[[CDAudioManager sharedManager] audioSourceForChannel:kASC_Four];
    humanTrumpets.delegate=self;
    
    femaleGroup=[[CDAudioManager sharedManager] audioSourceForChannel:kASC_Five];
    femaleGroup.delegate=self;
    
    beatBox=[[CDAudioManager sharedManager] audioSourceForChannel:kASC_Six];
    beatBox.delegate=self;
    
    didStartThemeSong=NO;
    
    [beeps load:BEEPS];
    [beatBox load:BEAT_BOX];
    [maleLow load:MALE_LOW];
    [humanTrumpets load:HUMAN_TRUMPETS];
    [femaleGroup load:FEMALE_GROUP];
}

-(void)playAudio
{
    [beatBox setMute:YES];
    [maleLow setMute:YES];
    [humanTrumpets setMute:YES];
    [femaleGroup setMute:YES];
    [beeps setMute:YES];
    
    [beatBox play];
    [maleLow play];
    [humanTrumpets play];
    [femaleGroup play];
    [beeps play];
    
    [beatBox setVolume:0.5f];
    [maleLow setVolume:0.5f];
    [humanTrumpets setVolume:0.5f];
    [femaleGroup setVolume:0.5f];
    [beeps setVolume:0.5f];
    
    [beatBox setNumberOfLoops:-1];
    [maleLow setNumberOfLoops:-1];
    [humanTrumpets setNumberOfLoops:-1];
    [femaleGroup setNumberOfLoops:-1];
    [beeps setNumberOfLoops:-1];
}
-(void)pauseAllAudio
{
    [beatBox pause];
    [maleLow pause];
    [humanTrumpets pause];
    [femaleGroup pause];
    [beeps pause];
}
-(void)resumeAllAudio
{
    [beatBox resume];
    [maleLow resume];
    [humanTrumpets resume];
    [femaleGroup resume];
    [beeps resume];
}
-(void)stopAllAudio
{
    [beatBox stop];
    [maleLow stop];
    [humanTrumpets stop];
    [femaleGroup stop];
    [beeps stop];
}

//-(void) cdAudioSourceDidFinishPlaying:(CDLongAudioSource *)audioSource
//{
//    if(!self.isMusicGameDone)
//    {
//        [self playBackgroundTrack:@"musicGameEnd.wav"];
//        [(audioMixerScene*)[[CCDirector sharedDirector] runningScene] launchEndGameScreen:[[CCDirector sharedDirector] runningScene]];
//    }
//    self.isMusicGameDone = YES;
//}


-(void)playBackgroundTrack:(NSString*)trackFileName 
{
    // Wait to make sure soundEngine is initialized
    if ((managerSoundState != kAudioManagerReady) && 
        (managerSoundState != kAudioManagerFailed)) 
    {
        int waitCycles = 0;
        while (waitCycles < AUDIO_MAX_WAITTIME) {
            [NSThread sleepForTimeInterval:0.1f];
            if ((managerSoundState == kAudioManagerReady) || 
                (managerSoundState == kAudioManagerFailed)) {
                break;
            }
            waitCycles = waitCycles + 1;
        }
    }
    
    if (managerSoundState == kAudioManagerReady) 
    {
        if ([soundEngine isBackgroundMusicPlaying]) 
        {
            [soundEngine stopBackgroundMusic];
        }
        [soundEngine preloadBackgroundMusic:trackFileName];
        [soundEngine playBackgroundMusic:trackFileName loop:NO];
    }
}

-(void)stopSoundEffect:(ALuint)soundEffectID 
{
    if (managerSoundState == kAudioManagerReady) 
    {
        [soundEngine stopEffect:soundEffectID];
    }
}

-(ALuint)playSoundEffect:(NSString*)soundEffectKey 
{
    ALuint soundID = 0;
    if (managerSoundState == kAudioManagerReady) 
    {
        NSNumber *isSFXLoaded = [soundEffectsState objectForKey:soundEffectKey];
        if ([isSFXLoaded boolValue] == SFX_LOADED) 
        {
            
            soundID = [soundEngine playEffect:[listOfSoundEffectFiles objectForKey:soundEffectKey]];
            //CCLOG(@"GameMgr: PLaying effect %@!", [listOfSoundEffectFiles objectForKey:soundEffectKey]);
        } 
        else 
        {
            CCLOG(@"GameMgr: SoundEffect %@ is not loaded, cannot play.",soundEffectKey);
        }
    } 
    else 
    {
        CCLOG(@"GameMgr: Sound Manager is not ready, cannot play %@", soundEffectKey);
    }
    return soundID;
}

- (NSString*)formatSceneTypeToString:(SceneTypes)sceneID 
{
    NSString *result = nil;
    switch(sceneID) 
    {
        case kNoSceneUninitialized:
            result = @"kNoSceneUninitialized";
            break;
        case kLoadingScene:
            result = @"kLoadingScene";
            break;
        case kAntFlickScene:
            result = @"kAntFlickScene";
            break;
        case kGIAntAudioRecorderScene:
            result = @"kGIAntAudioRecorderScene";
            break;
        case kGIAntCameraScene:
            result = @"kGIAntCameraScene";
            break;
        case kAudioMixerScene:
            result = @"kAudioMixerScene";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected SceneType."];
    }
    return result;
}

-(NSDictionary *)getSoundEffectsListForSceneWithID:(SceneTypes)sceneID 
{
    NSString *fullFileName = @"SoundEffects.plist";
    NSString *plistPath;
    
    // 1: Get the Path to the plist file
    NSString *rootPath = 
    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                         NSUserDomainMask, YES) 
     objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:fullFileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) 
    {
        plistPath = [[NSBundle mainBundle] 
                     pathForResource:@"SoundEffects" ofType:@"plist"];
    }
    
    // 2: Read in the plist file
    NSDictionary *plistDictionary = 
    [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    // 3: If the plistDictionary was null, the file was not found.
    if (plistDictionary == nil) 
    {
        CCLOG(@"Error reading SoundEffects.plist");
        return nil; // No Plist Dictionary or file found
    }
    
    // 4. If the list of soundEffectFiles is empty, load it
    if ((listOfSoundEffectFiles == nil) || 
        ([listOfSoundEffectFiles count] < 1)) 
    {
        [self setListOfSoundEffectFiles:
         [[NSMutableDictionary alloc] init]];
        for (NSString *sceneSoundDictionary in plistDictionary) 
        {
            [listOfSoundEffectFiles 
             addEntriesFromDictionary:
             [plistDictionary objectForKey:sceneSoundDictionary]];
        }
        CCLOG(@"Number of SFX filenames:%d", 
              [listOfSoundEffectFiles count]);
    }
    
    // 5. Load the list of sound effects state, mark them as unloaded
    if ((soundEffectsState == nil) || 
        ([soundEffectsState count] < 1)) 
    {
        [self setSoundEffectsState:[[NSMutableDictionary alloc] init]];
        for (NSString *SoundEffectKey in listOfSoundEffectFiles) 
        {
            [soundEffectsState setObject:[NSNumber numberWithBool:SFX_NOTLOADED] forKey:SoundEffectKey];
        }
    }
    
    // 6. Return just the mini SFX list for this scene
    NSString *sceneIDName = [self formatSceneTypeToString:sceneID];
    NSDictionary *soundEffectsList = 
    [plistDictionary objectForKey:sceneIDName];
    
    return soundEffectsList;
}


-(void)loadAudioForSceneWithID:(NSNumber*)sceneIDNumber 
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    
    SceneTypes sceneID = (SceneTypes) [sceneIDNumber intValue];
    
    if (managerSoundState == kAudioManagerInitializing) 
    {
        int waitCycles = 0;
        while (waitCycles < AUDIO_MAX_WAITTIME) 
        {
            [NSThread sleepForTimeInterval:0.1f];
            if ((managerSoundState == kAudioManagerReady) || 
                (managerSoundState == kAudioManagerFailed)) 
            {
                break;
            }
            waitCycles = waitCycles + 1;
        }
    }
    
    if (managerSoundState == kAudioManagerFailed) 
    {
        return; // Nothing to load, CocosDenshion not ready
    }
    
    NSDictionary *soundEffectsToLoad = 
    [self getSoundEffectsListForSceneWithID:sceneID];
    if (soundEffectsToLoad == nil) 
    { // 2
        CCLOG(@"Error reading SoundEffects.plist");
        return;
    }
    // Get all of the entries and PreLoad 
    for( NSString *keyString in soundEffectsToLoad )
    {
        CCLOG(@"\nLoading Audio Key:%@ File:%@", 
              keyString,[soundEffectsToLoad objectForKey:keyString]);
        [soundEngine preloadEffect:
         [soundEffectsToLoad objectForKey:keyString]]; 
        // 4
        [soundEffectsState setObject:[NSNumber numberWithBool:SFX_LOADED] forKey:keyString];
        
    }
    [pool release];
}

-(void)unloadAudioForSceneWithID:(NSNumber*)sceneIDNumber 
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    SceneTypes sceneID = (SceneTypes) [sceneIDNumber intValue];
    if (sceneID == kNoSceneUninitialized) 
    {
        return; // Nothing to unload
    }
    
    
    NSDictionary *soundEffectsToUnload = 
    [self getSoundEffectsListForSceneWithID:sceneID];
    if (soundEffectsToUnload == nil) 
    {
        CCLOG(@"Error reading SoundEffects.plist");
        return;
    }
    if (managerSoundState == kAudioManagerReady) 
    {
        // Get all of the entries and unload
        for( NSString *keyString in soundEffectsToUnload )
        {
            [soundEffectsState setObject:[NSNumber numberWithBool:SFX_NOTLOADED] forKey:keyString];
            [soundEngine unloadEffect:keyString];
            CCLOG(@"\nUnloading Audio Key:%@ File:%@", 
                  keyString,[soundEffectsToUnload objectForKey:keyString]);
            
        }
    }
    [pool release];
}




-(void)initAudioAsync 
{
    // Initializes the audio engine asynchronously
    managerSoundState = kAudioManagerInitializing; 
    // Indicate that we are trying to start up the Audio Manager
    [CDSoundEngine setMixerSampleRate:CD_SAMPLE_RATE_MID];
    
    //Init audio manager asynchronously as it can take a few seconds
    //The FXPlusMusicIfNoOtherAudio mode will check if the user is
    // playing music and disable background music playback if 
    // that is the case.
    [CDAudioManager initAsynchronously:kAMM_FxPlusMusicIfNoOtherAudio];
    
    //Wait for the audio manager to initialise
    while ([CDAudioManager sharedManagerState] != kAMStateInitialised) 
    {
        [NSThread sleepForTimeInterval:0.1];
    }
    
    //At this point the CocosDenshion should be initialized
    // Grab the CDAudioManager and check the state
    CDAudioManager *audioManager = [CDAudioManager sharedManager];
    if (audioManager.soundEngine == nil || 
        audioManager.soundEngine.functioning == NO) 
    {
        CCLOG(@"CocosDenshion failed to init, no audio will play.");
        managerSoundState = kAudioManagerFailed; 
    } else {
        [audioManager setResignBehavior:kAMRBStopPlay autoHandle:YES];
        soundEngine = [SimpleAudioEngine sharedEngine];
        managerSoundState = kAudioManagerReady;
        CCLOG(@"CocosDenshion is Ready");
    }
}


-(void)setupAudioEngine 
{
    if (hasAudioBeenInitialized == YES) 
    {
        return;
    } else 
    {
        hasAudioBeenInitialized = YES; 
        NSOperationQueue *queue = [[NSOperationQueue new] autorelease];
        NSInvocationOperation *asyncSetupOperation = 
        [[NSInvocationOperation alloc] initWithTarget:self 
                                             selector:@selector(initAudioAsync) 
                                               object:nil];
        [queue addOperation:asyncSetupOperation];
        [asyncSetupOperation autorelease];
    }
}

-(id)init 
{                                                        
    self = [super init];
    if (self != nil) 
    {
        // Game Manager initialized
        CCLOG(@"Game Manager Singleton, init");
        isMusicON = YES;
        isSoundEffectsON = YES;
        hasPlayerDied = NO;
        currentScene = kNoSceneUninitialized;
        hasAudioBeenInitialized = NO;
        runningAudioMixerFirstTime = YES;
        soundEngine = nil;
        managerSoundState = kAudioManagerUninitialized;
    }
    return self;
}
-(void)runSceneWithID:(SceneTypes)sceneID 
{
    lastLevel = curLevel;
    curLevel = sceneID;
    
    SceneTypes oldScene = currentScene;
    currentScene = sceneID;
    
    id sceneToRun = nil;
    switch (sceneID) 
    {
        case kGIAntAudioRecorderScene:
            sceneToRun = [giAntRecordingScene node];
            break;
        case kGIAntCameraScene:
            sceneToRun = [giAntCameraScene node];
            break;
        case kAudioMixerScene:
            sceneToRun = [audioMixerScene node];
            break;
        default:
            CCLOG(@"Unknown ID, cannot switch scenes");
            return;
            break;
    }
    
    if (sceneToRun == nil) 
    {
        // Revert back, since no new scene was found
        currentScene = oldScene;
        return;
    }
    
    [self performSelectorInBackground:@selector(loadAudioForSceneWithID:) withObject:[NSNumber numberWithInt:sceneID]];
    
    if (sceneID == kAudioMixerScene && runningAudioMixerFirstTime) 
    {
        [self initAudioForMixer];
        runningAudioMixerFirstTime = NO;
    }
    
    
    if ([[CCDirector sharedDirector] runningScene] == nil) 
    {
        [[CCDirector sharedDirector] runWithScene:sceneToRun];
        
    } else 
    {
        [[CCDirector sharedDirector] replaceScene:sceneToRun];
    }
    [self performSelectorInBackground:@selector(unloadAudioForSceneWithID:) withObject:[NSNumber numberWithInt:oldScene]];    
}


// Link Launcher
-(void)openSiteWithLinkType:(LinkTypes)linkTypeToOpen 
{
    NSURL *urlToOpen = nil;
    if (linkTypeToOpen == kLinkTypeWYNSite) 
    {
        urlToOpen = 
        [NSURL URLWithString:
         @"http://www.whatsyournews.com"];
    } 
    else if (linkTypeToOpen == kLinkTypeWinkerVSbecksSite) 
    {
        urlToOpen = [NSURL URLWithString:@"http://winkervsbecks.com"];
    } 
    else if (linkTypeToOpen == kLinkTypeWoodenGiantSite) 
    {
        urlToOpen = 
        [NSURL URLWithString:@"http://www.woodengiant.com/"];
    } 
    else
    {
        urlToOpen = 
        [NSURL URLWithString:@"http://www.whatsyournews.com"];
    }
    
    if (![[UIApplication sharedApplication] openURL:urlToOpen]) 
    {
        CCLOG(@"%@%@",@"Failed to open url:",[urlToOpen description]);
        [self runSceneWithID:kAntFlickScene];
    }    
}

@end
