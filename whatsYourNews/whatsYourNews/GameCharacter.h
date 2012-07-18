//
//  GameCharacter.h
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-06-06.
//  Copyright (c) 2012 winkerVSbecks. All rights reserved.
//

#import "GameObject.h"

@interface GameCharacter : GameObject {
    int characterHealth;
    CharacterStates characterState;
}

-(void)checkAndClampSpritePosition; 

@property (readwrite) CharacterStates characterState; 
@end
