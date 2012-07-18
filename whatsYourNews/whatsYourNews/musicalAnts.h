//
//  musicalAnts.h
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-05-30.
//  Copyright 2012 winkerVSbecks. All rights reserved.
//

/*************************************************************************
 
 # THE MUSICAL ANTS
 
 - Basically a toggle button with an animated sprite 
 - Two states on/off and a different animation for both to visualize this
 - Add a switch case to pick the ant type (initWithType)
 - Position remains fixed
 - Starts playing audio file at the begining but with volume = 0.0
 - Change volume to 1.0 on press
 
 **************************************************************************/

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "audioMixerScene.h"
#import "GameCharacter.h"
#import "SimpleAudioEngine.h"
#import "GameManager.h"

@interface musicalAnts : GameCharacter <CCTargetedTouchDelegate>  
{    
    CCAnimation *dancingAnim;
    
    int numUpdates;
    bool active;
}

@property (nonatomic, retain) CCAnimation *dancingAnim;
@property (nonatomic, readwrite) bool active;
@property (nonatomic, readwrite) int numUpdates;

-(void) toggleAudio;

@end
