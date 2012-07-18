//
//  audioMixerScene.m
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-05-29.
//  Copyright 2012 winkerVSbecks. All rights reserved.
//

#import "audioMixerScene.h"

@implementation audioMixerScene

-(id)init 
{
    self = [super init];
    if (self != nil) 
    { 
        // Static Background Layer
        tvSetBGLayer *aMixerBG = [tvSetBGLayer node];     
        [self addChild:aMixerBG z:1];
        
        // Interactive Layer: Musical Ants, Musical Object, etc
        antsAndObjectsLayer = [interactiveLayer node]; 
        [self addChild:antsAndObjectsLayer z:2 tag:45779975];     
        
        CCMenuItemImage *label = [CCMenuItemImage itemFromNormalImage:@"pauseButton.png" selectedImage:@"pauseButtonPressed.png" target:self selector:@selector(launchPauseScreen:)];

        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCMenu *menu = [CCMenu menuWithItems: label, nil];;
        menu.position = CGPointMake(size.width * 0.9, size.height * 0.88);
        [menu setColor:ccRED];
        [self addChild:menu z:9];
    }
    return self;
}

-(void) launchPauseScreen:(id)sender
{                
    if (!pauseScreenUp) 
    {
        pauseScreenUp = YES;
        
        [[GameManager sharedGameManager] playBackgroundTrack:@"paused.wav"];
        
        CGSize s = [[CCDirector sharedDirector] winSize];
        pausedLayer = [CCLayer node];
        pausedLayer.position = CGPointZero;
        [self addChild: pausedLayer z:10];
        
        backgroundImagePause = [CCSprite spriteWithFile:@"pauseBG.png"];
        [backgroundImagePause setPosition:CGPointMake(s.width/2, s.height/2)]; 
        [self addChild:backgroundImagePause z:10 tag:0];
        
        CCMenuItem *resumeAudioMixer = [CCMenuItemImage itemFromNormalImage:@"resume.png" selectedImage:@"resumePressed.png" target:self selector:@selector(resumeAudioMixer:)];
        
        CCMenuItem *restartGameFromBegining = [CCMenuItemImage itemFromNormalImage:@"restart.png" selectedImage:@"restartPressed.png" target:self selector:@selector(restartFromBegining:)];
        
        pauseScreenMenu = [CCMenu menuWithItems:resumeAudioMixer,restartGameFromBegining, nil];
        pauseScreenMenu.position = CGPointMake(s.width/2, s.height*0.70);
        pauseScreenMenu.anchorPoint = CGPointMake(0.5, 0.5);
        [pauseScreenMenu alignItemsHorizontallyWithPadding:20.0f];
        [self addChild:pauseScreenMenu z:12];
        
        [[CCDirector sharedDirector] pause];
        [[GameManager sharedGameManager] pauseAllAudio];
    }
}
-(void) resumeAudioMixer:(id)sender
{
    [[GameManager sharedGameManager].soundEngine stopBackgroundMusic];
	[self removeChild:pauseScreenMenu cleanup:YES];
	[self removeChild:pausedLayer cleanup:YES];
    [self removeChild:backgroundImagePause cleanup:YES];
    [[GameManager sharedGameManager] resumeAllAudio];
    pauseScreenUp = NO;
    
    [[CCDirector sharedDirector] resume];
}
-(void) restartFromBegining:(id)sender
{
    [self removeChild:pauseScreenMenu cleanup:YES];
	[self removeChild:pausedLayer cleanup:YES];
    [self removeChild:backgroundImagePause cleanup:YES];
    pauseScreenUp = NO;
    
    [[CCDirector sharedDirector] resume];
    
    [GameManager sharedGameManager].isMusicGameDone = YES;
    [antsAndObjectsLayer switchSceneAndCleanup];
}

//-(void) launchEndGameScreen:(id)sender
//{            
//    if (!endScreenUp) 
//    {
//        endScreenUp = YES;
//        
//        CGSize s = [[CCDirector sharedDirector] winSize];
//        endedLayer = [CCLayer node];
//        endedLayer.position = CGPointZero;
//        [self addChild: endedLayer z:10];
//        
//        backgroundImageEnd = [CCSprite spriteWithFile:@"endBG.png"];
//        [backgroundImageEnd setPosition:CGPointMake(s.width/2, s.height/2)]; 
//        [self addChild:backgroundImageEnd z:10 tag:0];
//        
//        CCMenuItem *restartJustAudioMixer = [CCMenuItemImage itemFromNormalImage:@"playAgain.png" selectedImage:@"playAgainPressed.png" target:self selector:@selector(restartAudioMixer:)];
//        
//        CCMenuItem *restartGameFromBegining = [CCMenuItemImage itemFromNormalImage:@"restartEnd.png" selectedImage:@"restartEndPressed.png" target:self selector:@selector(restartFromBegining:)];
//        
//        endScreenMenu = [CCMenu menuWithItems:restartJustAudioMixer,restartGameFromBegining, nil];
//        endScreenMenu.position = CGPointMake(s.width/2, s.height*0.88);
//        endScreenMenu.anchorPoint = CGPointMake(0.5, 0.5);
//        [endScreenMenu alignItemsHorizontallyWithPadding:20.0f];
//        [self addChild:endScreenMenu z:12];
//        
//        [[CCDirector sharedDirector] pause];
//        [[GameManager sharedGameManager] pauseAllAudio];
//    }
//}
//-(void) restartAudioMixer:(id)sender
//{
//    [GameManager sharedGameManager].isMusicGameDone = NO;
//    [[GameManager sharedGameManager].beeps rewind]; 
//    [[GameManager sharedGameManager].beatBox rewind];
//    [[GameManager sharedGameManager].femaleGroup rewind];
//    [[GameManager sharedGameManager].humanTrumpets rewind];
//    [[GameManager sharedGameManager].maleLow rewind];
//    
//    [self removeChild:endScreenMenu cleanup:YES];
//	[self removeChild:endedLayer cleanup:YES];
//    [self removeChild:backgroundImageEnd cleanup:YES];
//    endScreenUp = NO;
//    
//    [[GameManager sharedGameManager] resumeAllAudio];
//    [[CCDirector sharedDirector] resume];
//}

@end

