//
//  audioMixerScene.h
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-05-29.
//  Copyright 2012 winkerVSbecks. All rights reserved.
//

/***************************************************************************************
 
 # THE AUDIO MIXER TOY
 
 - Click on various ant characters to turn audio elements on/off
 - Click on various objects and bg ants to trigger sound samples
 - Special (easter egg) ants: Pete & Iggy which drop down from above randomly
    > Click to trigger sound
 - A TV in the background displays photo of the child (recorded in the 
    GI-Ant screen)
    > Click to trigger sound recorded by the child
 - Progress timer
 
 ## Audio samples belonging to the theme song all begin playing at the same time,
    when the scene starts
     > The core samples which are not allowed to be switched off will have
      volume = 1.0
     > The additional samples will start with volume = 0.0
        > when triggered volume = 1.0
 
 ## The bonus sounds (beeps, horns, funny noises, etc) will be of smaller lengths
     > On press trigger sound (instead of play)
 
 
 ## Related classes:
     > Ants (Derived from CCSprite, animated) 
     > Easter egg ants
     > Objects (clouds, light, speaker, etc.)
     > TV 
     > BG Layer with an image of the set
     > A layer of animated, not interactive, ants in the bg (can be combined 
        with the BG layer)
     > A layer for ants and objects which trigger sounds (with touch enabled)
     > UI Layer
        >> Timer (CCProgressTimer)
        >> Pause Button (maybe?)
        >> Any other buttons, if needed
     > Maybe an audio specific layer, but not sure if that is needed 
 
 ****************************************************************************************/

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "interactiveLayer.h"
#import "musicalAnts.h"
#import "tvSetBGLayer.h"

@interface audioMixerScene : CCScene {
	bool pauseScreenUp;
	CCLayer *pausedLayer;
    CCSprite *backgroundImagePause;
	CCMenu *pauseScreenMenu;
    
    bool endScreenUp;
	CCLayer *endedLayer;
    CCSprite *backgroundImageEnd;
    CCMenu *endScreenMenu;
    
    interactiveLayer *antsAndObjectsLayer;
}

-(void) launchPauseScreen:(id)sender;
//-(void) launchEndGameScreen:(id)sender;

@end


