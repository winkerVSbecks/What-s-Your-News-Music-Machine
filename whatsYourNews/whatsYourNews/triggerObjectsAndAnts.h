//
//  easterEggAnts.h
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-05-30.
//  Copyright 2012 winkerVSbecks. All rights reserved.
//

/*************************************************************************
 
 # THE EASTER EGG ANTS
 
 - Basically a toggle button with an animated sprite 
 - Two states on/off and a different animation for both to visualize this
 - Add a switch case to pick the ant type (initWithType)
 - Transition into the scene
 - Triggers audio on press
 
 
 # THE MUSICAL OBJECTS
 
 - Basically a toggle button with an animated sprite 
 - Two states on/off and a different animation for both to visualize this
 - Add a switch case to pick the object type (initWithType)
 - Position remains fixed
 
 **************************************************************************/

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameCharacter.h"
#import "audioMixerScene.h"
#import "CommonProtocols.h"

@interface triggerObjectsAndAnts : GameCharacter <CCTargetedTouchDelegate> 
{
    CCAnimation *dancingAnim;
    
    bool triggerable;
}

@property (nonatomic, retain) CCAnimation *dancingAnim;
@property (nonatomic, readwrite)bool triggerable;

@end
