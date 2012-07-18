//
//  GameCharacter.m
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-06-06.
//  Copyright (c) 2012 winkerVSbecks. All rights reserved.
//

#import "GameCharacter.h"

@implementation GameCharacter
@synthesize characterState; 

-(void) dealloc { 
    
    [super dealloc];
}

-(void)checkAndClampSpritePosition { 
    CGPoint currentSpritePosition = [self position];
    
    CGSize levelSize = [[CCDirector sharedDirector] winSize]; 
                            //[[GameManager sharedGameManager] getDimensionsOfCurrentScene];
    float xOffset;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // Clamp for the iPad
        xOffset = 30.0f;
    } else {
        // Clamp for iPhone, iPhone 4, or iPod touch
        xOffset = 24.0f;
    }
    
    if (currentSpritePosition.x < xOffset) {
        [self setPosition:ccp(xOffset, currentSpritePosition.y)];
    } else if (currentSpritePosition.x > (levelSize.width - xOffset)) {
        [self setPosition:ccp((levelSize.width - xOffset), currentSpritePosition.y)];
    }
}

@end
