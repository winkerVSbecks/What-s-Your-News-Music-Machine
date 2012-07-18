//
//  musicalAnts.m
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-05-30.
//  Copyright 2012 winkerVSbecks. All rights reserved.
//

#import "musicalAnts.h"
#import "interactiveLayer.h"
#import "GameManager.h"


@implementation musicalAnts

@synthesize dancingAnim, active, numUpdates;


-(void) dealloc
{
	// Must manually unschedule, it is not done automatically for you in non-CCNode classes!
	[[CCScheduler sharedScheduler] unscheduleUpdateForTarget:self];
    
    [dancingAnim release];    
	[super dealloc];
}

-(void)checkAndClampSpritePosition 
{
    [super checkAndClampSpritePosition];
}


-(void)changeState:(CharacterStates)newState 
{
    [self stopAllActions];
    id action = nil;
    [self setCharacterState:newState];
    [self setColor:ccGRAY];
    
    switch (newState) {
            
        case kStateIdle:            
                switch (self.tag) 
            {
                case kAntony:
                    [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                                sharedSpriteFrameCache] 
                                               spriteFrameByName:@"Antony_1.png"]]; 
                    break;
                    
                case kGrant:
                    [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                                sharedSpriteFrameCache] 
                                               spriteFrameByName:@"Grant_1.png"]]; 
                    break;
                    
                case KDrummer:
                    [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                                sharedSpriteFrameCache] 
                                               spriteFrameByName:@"Drummer_1.png"]]; 
                    break;
                    
                case kSinger:
                    [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                                sharedSpriteFrameCache] 
                                               spriteFrameByName:@"Singer_1.png"]]; 
                    break;
                    
                case kTrumpetPlayer:
                    [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                                sharedSpriteFrameCache] 
                                               spriteFrameByName:@"Trumpet_1.png"]];
                    break;
                    
                default:
                    break;
            }
            break;
            
        case kStateAnimated:  
            [self setColor:ccWHITE];
            [self setScale:1.0f];
            if (self.dancingAnim != nil) {
                action = [CCAnimate actionWithAnimation:self.dancingAnim restoreOriginalFrame:YES];  
                CCAnimate *animationOfAnt = [CCAnimate actionWithAnimation:dancingAnim];
                action = [CCRepeatForever actionWithAction:animationOfAnt];
            }
            break;
            
        default:
            break;
    }
    
    [self toggleAudio];
    
    if (action != nil) {
        [self runAction:action];
    }
}

-(void) toggleAudio 
{    
    switch (self.tag) 
    {
        case kAntonySpriteTagValue:
            if (kStateAnimated == self.characterState ) {
                [[GameManager sharedGameManager].maleLow setMute:NO];
            }else{
                [[GameManager sharedGameManager].maleLow setMute:YES];
            }
            break;
            
        case kGrantSpriteTagValue:
            if (kStateAnimated == self.characterState ) {
                [[GameManager sharedGameManager].beeps setMute:NO];
            }else{
               [[GameManager sharedGameManager].beeps setMute:YES];
            }
            break;
            
        case kTrumpetSpriteTagValue:
            if (kStateAnimated == self.characterState ) {
                [[GameManager sharedGameManager].humanTrumpets setMute:NO];
            }else{
                [[GameManager sharedGameManager].humanTrumpets setMute:YES];
            }
            break;
            
        case KDrummerSpriteTagValue:
            if (kStateAnimated == self.characterState ) {     
                [[GameManager sharedGameManager].beatBox setMute:NO];
            }else{
                [[GameManager sharedGameManager].beatBox setMute:YES];
            }
            break;
            
        case kSingerSpriteTagValue:
            if (kStateAnimated == self.characterState ) {           
                [[GameManager sharedGameManager].femaleGroup setMute:NO];
            }else{                
                [[GameManager sharedGameManager].femaleGroup setMute:YES];
            }
            break;
            
        default:
            break;
    }
}


-(void)pickTextures 
{
    switch (self.gameObjectType) 
    {
        case kAntony:
            [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Antony_1.png"]]; 
            [self setDancingAnim:[self loadPlistForAnimationWithName:@"AntonyAnim" andClassName:NSStringFromClass([self class])]]; 
            break;
            
        case kGrant:
            [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Grant_1.png"]]; 
            [self setDancingAnim:[self loadPlistForAnimationWithName:@"GrantAnim" andClassName:NSStringFromClass([self class])]]; 
            break;
        
        case KDrummer:
            [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Drummer_1.png"]]; 
            [self setDancingAnim:[self loadPlistForAnimationWithName:@"DrummerAnim" andClassName:NSStringFromClass([self class])]];
            break;
            
        case kSinger:
            [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Singer_1.png"]]; 
            [self setDancingAnim:[self loadPlistForAnimationWithName:@"SingerAnim" andClassName:NSStringFromClass([self class])]];
            break;
        
        case kTrumpetPlayer:
            [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Trumpet_1.png"]];
            [self setDancingAnim:[self loadPlistForAnimationWithName:@"TrumpetAnim" andClassName:NSStringFromClass([self class])]];
            break;
            
        default:
            break;
    }
    [self setColor:ccGRAY];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [interactiveLayer locationFromTouch:touch];
    
	// Check if this touch is on the musicalAnt's sprite.
    BOOL isTouchHandled = CGRectContainsPoint([self adjustedBoundingBox], touchLocation);
	if (isTouchHandled)
	{                
        if(![GameManager sharedGameManager].didStartThemeSong)
        {
            [[GameManager sharedGameManager].soundEngine stopBackgroundMusic];
            
            [GameManager sharedGameManager].didStartThemeSong = YES;
            [[GameManager sharedGameManager] playAudio];
        }
        
        if(self.characterState == kStateIdle)
        {
            [self changeState: kStateAnimated];
        }
        else
        {
            [self changeState: kStateIdle];
        }
	}
	return isTouchHandled;
}


-(id) initWithGameObjectType:(GameObjectType)kObject 
{
    if( (self=[super init]) ) 
    {
        self.gameObjectType = kObject;
        [self pickTextures];
    }
    return self;
}

- (void) onEnter
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];
    
    [super onEnter];
}

- (void) onExit
{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    
    [super onExit];
}

@end
