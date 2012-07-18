//
//  audioRecordingLayer.m
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-06-17.
//  Copyright 2012 winkerVSbecks. All rights reserved.
//

#import "audioRecordingLayer.h"


@implementation audioRecordingLayer


@synthesize destinationString;
@synthesize continueToNextScene;
@synthesize startRecording;
@synthesize giAntTalkAnimation, giAntIntroAnimation;
@synthesize giAnt;
@synthesize time;
@synthesize loadTicker;

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
        
        // BG IMAGE
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
            
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"recorderScene.plist"];          
        sceneSpriteBatchNode = 
        [CCSpriteBatchNode batchNodeWithFile:@"recorderScene.png"];
        [self addChild:sceneSpriteBatchNode z:0];
        
        CCSprite *backgroundImage;
        backgroundImage = [CCSprite spriteWithSpriteFrameName:@"recorderBG.png"];
        [backgroundImage setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)]; 
        [sceneSpriteBatchNode addChild:backgroundImage z:2 tag:0];
        
        giAnt = [CCSprite spriteWithSpriteFrameName:@"giAnt_0.png"];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            [giAnt setPosition:ccp(screenSize.width*0.399f, screenSize.height*0.340f)];
        }else {
            [giAnt setPosition:ccp(screenSize.width*0.435f, screenSize.height*0.423f)];
        }
        [sceneSpriteBatchNode addChild:giAnt z:1];
        
        timer = [CCProgressTimer progressWithFile:@"recordTimer.png"];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
             [timer setPosition:ccp(screenSize.width*0.396f, screenSize.height*0.361f)];
        }else {
            [timer setPosition:ccp(screenSize.width*0.444f, screenSize.height*0.359f)];
        }
        timer.type = kCCProgressTimerTypeRadialCW;
        timer.percentage = 0.0f;
        [self addChild:timer z:4 tag:kAntFlickLayerTagProgressTimer];
        
        CCSprite *playButton = [CCSprite spriteWithSpriteFrameName:@"play.png"];
        CCSprite *playButtonPressed = [CCSprite spriteWithSpriteFrameName:@"play.png"];
        [playButton setColor:ccc3(200, 200, 200)];
        [playButtonPressed setColor:ccWHITE];
        
        
        CCSprite *recordButton = [CCSprite spriteWithSpriteFrameName:@"record.png"];
        CCSprite *recordButtonPressed = [CCSprite spriteWithSpriteFrameName:@"record.png"];
        [recordButton setColor:ccc3(200, 200, 200)];
        [recordButtonPressed setColor:ccWHITE];
        
		CCMenuItemSprite *playRecordItem = [CCMenuItemSprite itemFromNormalSprite:playButton selectedSprite:playButtonPressed]; //target:self selector:@selector(playRecord)
		
		CCMenuItemSprite *startRecordItem = [CCMenuItemSprite itemFromNormalSprite:recordButton selectedSprite:recordButtonPressed]; //target:self selector:@selector(startRecordWithAlert)
        
        CCMenu *menu = [CCMenu menuWithItems: startRecordItem, playRecordItem, nil];
        menu.rotation=10.0f;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            [menu alignItemsHorizontallyWithPadding:310.0f];
            menu.position = ccp(screenSize.width*0.515f, screenSize.height*0.66f);
        }else {
            [menu alignItemsHorizontallyWithPadding:133.0f];
            menu.position = ccp(screenSize.width*0.552f, screenSize.height*0.656f);
        }
        [self addChild:menu z:4];
        
        
        giAntIntroAnimation = [CCAnimation animation];
        [giAntIntroAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_0.png"]];
        [giAntIntroAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_1.png"]];
        [giAntIntroAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_2.png"]];
        [giAntIntroAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_3.png"]];
        [giAntIntroAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_4.png"]];
        [giAntIntroAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_5.png"]];
        [giAntIntroAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_6.png"]];
        [giAntIntroAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_7.png"]];
        [giAntIntroAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_8.png"]];
        [giAntIntroAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_9.png"]];
        [giAntIntroAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_10.png"]];
        [giAntIntroAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_11.png"]];
        [giAntIntroAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_12.png"]];
        
        giAntTalkAnimation = [CCAnimation animation];
        [giAntTalkAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_6.png"]];
        [giAntTalkAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_7.png"]];
        [giAntTalkAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_8.png"]];
        [giAntTalkAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_9.png"]];
        [giAntTalkAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_10.png"]];
        [giAntTalkAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_11.png"]];
        [giAntTalkAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_12.png"]];
        [giAntTalkAnimation retain];
        
        id introAnimationAction = [CCAnimate actionWithDuration:1.5 animation:giAntIntroAnimation restoreOriginalFrame:NO];
        
        id talkAnimationAction = [CCAnimate actionWithDuration:0.5 animation:giAntTalkAnimation restoreOriginalFrame:YES];
                
        id runAnimations = [CCSequence actions:introAnimationAction, talkAnimationAction, talkAnimationAction, talkAnimationAction, talkAnimationAction, talkAnimationAction, talkAnimationAction, talkAnimationAction, talkAnimationAction,  talkAnimationAction, talkAnimationAction, talkAnimationAction, talkAnimationAction, talkAnimationAction, talkAnimationAction, talkAnimationAction, talkAnimationAction, talkAnimationAction, talkAnimationAction, nil];
        
        [giAnt runAction:runAnimations];
        
        [[GameManager sharedGameManager] playBackgroundTrack:@"touchName.wav"];
       
        self.startRecording = NO;
        self.continueToNextScene = NO;
        self.isTouchEnabled = YES;
		
	}
	return self;
}

-(void) initRecord
{
    [[CDAudioManager sharedManager] setMode:kAMM_PlayAndRecord];
    
	audioSession = [[AVAudioSession sharedInstance] retain];
	[audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: nil];
	[audioSession setActive:YES error:nil];
    
//****************If you want unique file name, use this:    
//	destinationString = [[self documentsPath]
//						 stringByAppendingPathComponent:@"test.mp3"];
//    
//	NSURL *destinationURL = [NSURL fileURLWithPath: destinationString];
//	
//    destinationString = [self getUniqueFilenameInFolder:[self documentsPath] forFileExtension:@"caf"];
    
    destinationString = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/audioSample.caf"];
    
    NSLog(@"%@", destinationString);
    
    [GameManager sharedGameManager].destinationURL = [NSURL fileURLWithPath: destinationString];
    
	NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
							  [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
							  [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
							  [NSNumber numberWithInt: 1],                         AVNumberOfChannelsKey,
							  [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
							  nil];
	
	NSError *error;
	
	recorder = [[AVAudioRecorder alloc] initWithURL:[GameManager sharedGameManager].destinationURL settings:settings error:&error];
	recorder.delegate = self;
    
    self.time = 0;
    [self startRecord];
}

- (NSString*) documentsPath
{
	NSArray *searchPaths =
	NSSearchPathForDirectoriesInDomains
	(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* _documentsPath = [searchPaths objectAtIndex: 0];
	[_documentsPath retain];
	
	return _documentsPath;
}

-(NSString *)getUniqueFilenameInFolder:(NSString *)folder forFileExtension:(NSString *)fileExtension {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *existingFiles = [fileManager contentsOfDirectoryAtPath:folder error:nil];
    NSString *uniqueFilename;
    
    do {
        CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
        CFStringRef newUniqueIdString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
        
        uniqueFilename = [[folder stringByAppendingPathComponent:(NSString *)newUniqueIdString] stringByAppendingPathExtension:fileExtension];
        
        CFRelease(newUniqueId);
        CFRelease(newUniqueIdString);
    } while ([existingFiles containsObject:uniqueFilename]);
    
    return uniqueFilename;
}

-(void) checkMic
{
	if ( audioSession.inputIsAvailable) {
        
		NSLog(@"Mic connected");
	}
	else {
		NSLog(@"Mic not connected");
	}
}

-(void) startRecord
{
	if (recorder) 
    {
		[recorder prepareToRecord];
		recorder.meteringEnabled = NO;
        [recorder recordForDuration:kTimeRecordedAudioLength];
        [self scheduleUpdate];
	} 
}
-(void) stopRecord
{
	[recorder stop];
}
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder 
						   successfully:(BOOL)flag
{
	if (flag)
    {
		NSLog(@"audioRecorderDidFinishRecording OK");
        
        self.continueToNextScene = YES;
        
        [self playRecord];
        [self unscheduleUpdate];
	}
	else 
    {
		NSLog(@"audioRecorderDidFinishRecording ERROR");
	}
}

-(void) playRecord
{   
    if(self.continueToNextScene)
    {
        NSString *urlString = [[GameManager sharedGameManager].destinationURL absoluteString];
        NSLog(@"Play Destination: %@", urlString);

        if(player.isPlaying){
            [player stop];
        }
        
        player =[[AVAudioPlayer alloc] initWithContentsOfURL:[GameManager sharedGameManager].destinationURL error:NULL];
        player.delegate = self;	
        [player play];
        
        [[CDAudioManager sharedManager] setMode:kAMM_FxPlusMusic];
    }
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag) 
    {      
        [[CDAudioManager sharedManager] setMode:kAMM_FxPlusMusic];
        [[GameManager sharedGameManager].soundEngine stopBackgroundMusic];
        [[GameManager sharedGameManager] runSceneWithID:kGIAntCameraScene];
	}
	else 
    {
		NSLog(@"audioPlayerDidFinishPlaying ERROR");
	}
}
-(void) ticker:(ccTime) dt
{
    if (loadTicker==0) 
    {
        [[GameManager sharedGameManager] playBackgroundTrack:@"beepyLarry.wav"];
        timer.percentage=100.0f;
        id pulseAction = [CCBlink actionWithDuration:0.5f blinks:3];
        [timer runAction:pulseAction];
    }
    if(loadTicker==1.0) {
        timer.percentage=0.0f;
        [self initRecord];
        [self unschedule:@selector(loadTicker:)];
    }
    loadTicker+=0.5;
}
-(void) update:(ccTime)deltaTime
{
    time = time+deltaTime;
    
    // Update Timer
    CCNode* node = [self getChildByTag:kAntFlickLayerTagProgressTimer];
    NSAssert([node isKindOfClass:[CCProgressTimer class]], @"node is not a CCProgressTime");
    if (timer.percentage <= 100) {
        timer.percentage = (time/kTimeRecordedAudioLength)*100;
    }
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.continueToNextScene) 
    {
        //===========SEE AUTOMATED ACTION ABOVE!===========
        
        [player stop];
        [[CDAudioManager sharedManager] setMode:kAMM_FxPlusMusic];
        [[GameManager sharedGameManager].soundEngine stopBackgroundMusic];
        [[GameManager sharedGameManager] runSceneWithID:kGIAntCameraScene];
        
        //[[GameManager sharedGameManager] runSceneWithID:kAudioMixerScene];
    }
    
    if (!self.startRecording) {
        
        [giAnt stopAllActions];
        
        [self startRecordWithAlert];
    }
}
-(void) startRecordWithAlert
{
    [[GameManager sharedGameManager].soundEngine stopBackgroundMusic];
    self.startRecording = YES;
    loadTicker=0;
    [self schedule:@selector(ticker:) interval:0.5f];
}

- (void) dealloc
{   
	[super dealloc];
}


@end
