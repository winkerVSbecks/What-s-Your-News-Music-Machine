//
//  easterEggAnts.m
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-05-30.
//  Copyright 2012 winkerVSbecks. All rights reserved.
//

#import "triggerObjectsAndAnts.h"


@implementation triggerObjectsAndAnts

@synthesize dancingAnim, triggerable;


-(void)changeState:(CharacterStates)newState 
{
    [self stopAllActions];
    id action = nil;
    [self setCharacterState:newState];
    [self setColor:ccGRAY];
    
    switch (newState) {
            
        case kStateIdle: 
            [self setColor:ccGRAY];
            switch (self.tag) 
        {
            case kClownSpriteTagValue:
                [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                            sharedSpriteFrameCache] 
                                           spriteFrameByName:@"Clown_1.png"]]; 
                break;
            case kBeeSpriteTagValue:
                [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                            sharedSpriteFrameCache] 
                                           spriteFrameByName:@"Bee_1.png"]]; 
                break;
            case kPlaneSpriteTagValue:
                [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                            sharedSpriteFrameCache] 
                                           spriteFrameByName:@"Plane_1.png"]]; 
                break;
            case kButterflySpriteTagValue:
                [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                            sharedSpriteFrameCache] 
                                           spriteFrameByName:@"Butterfly_1.png"]]; 
                break;
            case kSaxSpriteTagValue:
                [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                            sharedSpriteFrameCache] 
                                           spriteFrameByName:@"Sax_4.png"]]; 
                break;
            case kGuitaristSpriteTagValue:
                [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                            sharedSpriteFrameCache] 
                                           spriteFrameByName:@"Guitar_1.png"]]; 
                break;
            case kBalloonSpriteTagValue:
                [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                            sharedSpriteFrameCache] 
                                           spriteFrameByName:@"Balloons_1.png"]]; 
                break;
            case kGirlOnCloudLeftSpriteTagValue:
                [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                            sharedSpriteFrameCache] 
                                           spriteFrameByName:@"Girl1_1.png"]]; 
                break;
            case kGirlOnCloudMiddleSpriteTagValue:
                [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                            sharedSpriteFrameCache] 
                                           spriteFrameByName:@"Girl2_7.png"]]; 
                break;
            case kGirlOnCloudRightSpriteTagValue:
                [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                            sharedSpriteFrameCache] 
                                           spriteFrameByName:@"Girl3_1.png"]]; 
                break;

            case kSunSpriteTagValue:
                [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                            sharedSpriteFrameCache] 
                                           spriteFrameByName:@"Sun_10.png"]]; 
                [self setDancingAnim:[self loadPlistForAnimationWithName:@"SunAnim" andClassName:NSStringFromClass([self class])]];
                break;
                
            case kCheerleader1SpriteTagValue:
                [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                            sharedSpriteFrameCache] 
                                           spriteFrameByName:@"Cheerleader1_6.png"]]; 
                [self setDancingAnim:[self loadPlistForAnimationWithName:@"Cheerleader1Anim" andClassName:NSStringFromClass([self class])]];
                break;
                
            case kCheerleader2SpriteTagValue:
                [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                            sharedSpriteFrameCache] 
                                           spriteFrameByName:@"Cheerleader2_6.png"]]; 
                [self setDancingAnim:[self loadPlistForAnimationWithName:@"Cheerleader2Anim" andClassName:NSStringFromClass([self class])]];
                break;
                
            default:
                break;
        }
            break;
            
        case kStateTriggered:
            switch (self.tag) 
        {
            case kClownSpriteTagValue:
                break;
            case kCheerleader1SpriteTagValue: 
                break;
            case kCheerleader2SpriteTagValue:
                break;
            case kSaxSpriteTagValue:
                break;
            case kGuitaristSpriteTagValue:
                break;
            case kBeeSpriteTagValue:
                action = [CCMoveTo actionWithDuration:0.5f position:kLocFlickBee]; 
                break;
            case kPlaneSpriteTagValue:
                action = [CCMoveTo actionWithDuration:0.5f position:kLocFlickPlane];
                break;
            case kButterflySpriteTagValue:
                action = [CCMoveTo actionWithDuration:0.5f position:kLocFlickButterfly]; 
                break;
            case kBalloonSpriteTagValue:
                action = [CCMoveTo actionWithDuration:0.5f position:kLocFlickBalloon]; 
                break;
            case kGirlOnCloudLeftSpriteTagValue:
                action = [CCMoveTo actionWithDuration:0.5f position:kLocFlickGirlOnCloudLeft]; 
                break;
            case kGirlOnCloudMiddleSpriteTagValue:
                action = [CCMoveTo actionWithDuration:0.5f position:kLocFlickGirlOnCloudMiddle];
                break;
            case kGirlOnCloudRightSpriteTagValue:
                action = [CCMoveTo actionWithDuration:0.5f position:kLocFlickGirlOnCloudRight]; 
                break;
            case kSunSpriteTagValue:
                action = [CCMoveTo actionWithDuration:0.5f position:kLocFlickSun]; 
                break;
            default:
                break;
        }
            break;
            
        case kStateUnTriggered:
            switch (self.tag) 
        {
            case kClownSpriteTagValue:
                break;
            case kSaxSpriteTagValue:
                break;
            case kGuitaristSpriteTagValue:
                break;
            case kCheerleader1SpriteTagValue:
                break;
            case kCheerleader2SpriteTagValue:
                break;
            case kBeeSpriteTagValue:
                action = [CCMoveTo actionWithDuration:0.5f position:kLocFlickBeeUnTriggered]; 
                break;
            case kPlaneSpriteTagValue:
                action = [CCMoveTo actionWithDuration:0.5f position:kLocFlickPlaneUnTriggered];
                break;
            case kButterflySpriteTagValue:
                action = [CCMoveTo actionWithDuration:0.5f position:kLocFlickButterflyUnTriggered]; 
                break;
            case kBalloonSpriteTagValue:
                action = [CCMoveTo actionWithDuration:0.5f position:kLocFlickBalloonUnTriggered]; 
                break;
            case kGirlOnCloudLeftSpriteTagValue:
                action = [CCMoveTo actionWithDuration:0.5f position:kLocFlickGirlOnCloudLeftUnTriggered]; 
                break;
            case kGirlOnCloudMiddleSpriteTagValue:
                action = [CCMoveTo actionWithDuration:0.5f position:kLocFlickGirlOnCloudMiddleUnTriggered];
                break;
            case kGirlOnCloudRightSpriteTagValue:
                action = [CCMoveTo actionWithDuration:0.5f position:kLocFlickGirlOnCloudRightUnTriggered]; 
                break;
            case kSunSpriteTagValue:
                action = [CCMoveTo actionWithDuration:0.5f position:kLocFlickSunUnTriggered]; 
                break;
            default:
                break;
        }
            break;
            
        case kStateAnimated:  
            [self setColor:ccWHITE];

            if (self.dancingAnim != nil) {
                id animAction = [CCAnimate actionWithAnimation:self.dancingAnim restoreOriginalFrame:YES];  
                id actionChangeCol = [CCTintTo actionWithDuration:0.5 red:166 green:166 blue:166]; 
                action = [CCSequence actions:animAction,actionChangeCol, nil];
            }
            break;
            
        default:
            break;
    }
    
    if (action != nil) {
        [self runAction:action];
    }
}

-(void)pickTextures 
{   
    switch (self.gameObjectType) 
    {
        case kClown:
            [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Clown_1.png"]]; 
            [self setDancingAnim:[self loadPlistForAnimationWithName:@"ClownAnim" andClassName:NSStringFromClass([self class])]];
            triggerable = NO;
            break;
        
        case kSax:
            [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Sax_4.png"]]; 
            [self setDancingAnim:[self loadPlistForAnimationWithName:@"SaxAnim" andClassName:NSStringFromClass([self class])]];
            triggerable = NO;
            break;
            
        case kGuitarist:
            [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Guitar_1.png"]]; 
            [self setDancingAnim:[self loadPlistForAnimationWithName:@"GuitarAnim" andClassName:NSStringFromClass([self class])]];
            triggerable = NO;
            break;
        
        case kCheerleader1:
            [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Cheerleader1_6.png"]]; 
            [self setDancingAnim:[self loadPlistForAnimationWithName:@"Cheerleader1Anim" andClassName:NSStringFromClass([self class])]];
            triggerable = NO;
            break;
            
        case kCheerleader2:
            [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Cheerleader2_6.png"]]; 
            [self setDancingAnim:[self loadPlistForAnimationWithName:@"Cheerleader2Anim" andClassName:NSStringFromClass([self class])]];
            triggerable = NO;
            break;
            
        case kBee:
            [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Bee_1.png"]]; 
            [self setDancingAnim:[self loadPlistForAnimationWithName:@"BeeAnim" andClassName:NSStringFromClass([self class])]];
            triggerable = YES;
            break;
            
        case kPlane:
            [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Plane_1.png"]]; 
            [self setDancingAnim:[self loadPlistForAnimationWithName:@"PlaneAnim" andClassName:NSStringFromClass([self class])]];
            triggerable = YES;
            break;
            
        case kButterfly:
            [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Butterfly_1.png"]]; 
            [self setDancingAnim:[self loadPlistForAnimationWithName:@"ButterflyAnim" andClassName:NSStringFromClass([self class])]];
            triggerable = YES;
            break;

        case kBalloon:
            [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Balloons_1.png"]]; 
            [self setDancingAnim:[self loadPlistForAnimationWithName:@"BalloonAnim" andClassName:NSStringFromClass([self class])]];
            triggerable = YES;
            break;
            
        case kGirlOnCloudLeft:
            [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Girl1_1.png"]]; 
            [self setDancingAnim:[self loadPlistForAnimationWithName:@"Girl1Anim" andClassName:NSStringFromClass([self class])]];
            triggerable = YES;
            break;
            
        case kGirlOnCloudMiddle:
            [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Girl2_7.png"]]; 
            [self setDancingAnim:[self loadPlistForAnimationWithName:@"Girl2Anim" andClassName:NSStringFromClass([self class])]];
            triggerable = YES;
            break;
            
        case kGirlOnCloudRight:
            [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Girl3_1.png"]]; 
            [self setDancingAnim:[self loadPlistForAnimationWithName:@"Girl3Anim" andClassName:NSStringFromClass([self class])]];
            triggerable = YES;
            break;
            
        case kSun:
            [self initWithSpriteFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Sun_10.png"]]; 
            [self setDancingAnim:[self loadPlistForAnimationWithName:@"SunAnim" andClassName:NSStringFromClass([self class])]];
            triggerable = YES;
            break;
            
        default:
            break;
    }
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [interactiveLayer locationFromTouch:touch];
    
    BOOL isTouchHandled = CGRectContainsPoint([self adjustedBoundingBox], touchLocation);
    
	if (isTouchHandled && self.characterState != kStateUnTriggered)
	{         
        [self changeState:kStateAnimated];
        
        switch (self.tag) 
        {
            case kClownSpriteTagValue:
                //[[GameManager sharedGameManager].soundEngine playBackgroundMusic:@"whistle.wav" loop:NO];
                PLAYSOUNDEFFECT(RASPBERRY);
                break;
            case kBeeSpriteTagValue:
                PLAYSOUNDEFFECT(TARZAN);
                break;
            case kPlaneSpriteTagValue:
                break;
            case kButterflySpriteTagValue:
                PLAYSOUNDEFFECT(YODEL);
                break;
            case kSaxSpriteTagValue:
                PLAYSOUNDEFFECT(ANT_TRUMPET);
                break;
            case kGuitaristSpriteTagValue:
                [[GameManager sharedGameManager].soundEngine playBackgroundMusic:@"guitar.wav" loop:NO];
                break;
            case kBalloonSpriteTagValue:
                [[GameManager sharedGameManager].soundEngine playBackgroundMusic:@"fx.wav" loop:NO];
                break;
            case kGirlOnCloudLeftSpriteTagValue:
                //PLAYSOUNDEFFECT(AGOGO);
                [[GameManager sharedGameManager].soundEngine playBackgroundMusic:@"agogo.wav" loop:NO];
                break;
            case kGirlOnCloudMiddleSpriteTagValue:
                PLAYSOUNDEFFECT(TAOURINE);
                break;
            case kGirlOnCloudRightSpriteTagValue:
                //PLAYSOUNDEFFECT(TABLA);
                [[GameManager sharedGameManager].soundEngine playBackgroundMusic:@"stng11.wav" loop:NO];
                break;
            case kSunSpriteTagValue:
                //PLAYSOUNDEFFECT(THIS_JUST_IN);
                [[GameManager sharedGameManager].soundEngine playBackgroundMusic:@"thisJustIn.wav" loop:NO];
                break;
            case kCheerleader1SpriteTagValue:
                PLAYSOUNDEFFECT(TABLA);
                break;
            case kCheerleader2SpriteTagValue:
                PLAYSOUNDEFFECT(CHIMES);
                break;
                
            default:
                break;
        }
	}
    
	return isTouchHandled;
}


-(id) initWithGameObjectType:(GameObjectType)kObject 
{
    if( (self=[super init]) ) {
        
        self.gameObjectType = kObject;
        [self pickTextures];
        [self setColor:ccGRAY];
    }
    return self;
}

- (void) onEnter
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:2 swallowsTouches:YES];
    [super onEnter];
}
- (void) onExit
{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [[CCScheduler sharedScheduler] unscheduleUpdateForTarget:self];
    [super onExit];
}
-(void) dealloc
{	
    [dancingAnim release];
	[super dealloc];
}

@end
