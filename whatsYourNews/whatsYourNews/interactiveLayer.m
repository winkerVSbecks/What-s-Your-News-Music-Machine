//
//  interactiveLayer.m
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-06-07.
//  Copyright 2012 winkerVSbecks. All rights reserved.
//

#import "interactiveLayer.h"
#import "musicalAnts.h"
#import "audioMixerScene.h"
#import "triggerObjectsAndAnts.h"


@implementation interactiveLayer


-(id) init
{
	if ((self = [super init]))
	{
		//CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        [[GameManager sharedGameManager] playBackgroundTrack:@"audioMixerIntro.wav"];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"antTextures.plist"]; 
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"triggerTextures.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"triggerTextures2.plist"];
        
        sceneSpriteBatchNode = 
        [CCSpriteBatchNode batchNodeWithFile:@"antTextures.png"];
        [self addChild:sceneSpriteBatchNode z:3];
        triggersSpriteBatchNode = 
        [CCSpriteBatchNode batchNodeWithFile:@"triggerTextures.png"];
        [self addChild:triggersSpriteBatchNode z:8];
        triggersSpriteBatchNodeTwo = 
        [CCSpriteBatchNode batchNodeWithFile:@"triggerTextures2.png"];
        [self addChild:triggersSpriteBatchNodeTwo z:8];
        
        
        // Load some voice
         player =[[AVAudioPlayer alloc] initWithContentsOfURL:[GameManager sharedGameManager].destinationURL error:NULL];
        player.delegate = self;
        
        
        // Create Musical Ants
        [self createObjectOfType:kAntony atLocation:kLocAntonyIphone withZValue:3];
        [self createObjectOfType:kTrumpetPlayer atLocation:kLocTrumpetIphone withZValue:3];
        [self createObjectOfType:kGrant atLocation:kLocGrantIphone withZValue:3];
        [self createObjectOfType:KDrummer atLocation:kLocDrummerIphone withZValue:3];
        [self createObjectOfType:kSinger atLocation:kLocSingerIphone withZValue:3];
        
        
        // Create Trigger Object and Ants
        [self createObjectOfType:kBalloon atLocation:kLocFlickBalloon withZValue:8];
        [self createObjectOfType:kButterfly atLocation:kLocFlickButterfly withZValue:8];
        [self createObjectOfType:kGirlOnCloudLeft atLocation:kLocFlickGirlOnCloudLeft withZValue:8];
        [self createObjectOfType:kGirlOnCloudMiddle atLocation:kLocFlickGirlOnCloudMiddle withZValue:8];
        [self createObjectOfType:kGirlOnCloudRight atLocation:kLocFlickGirlOnCloudRight withZValue:8];
        
        [self createObjectOfType:kClown atLocation:kLocAMClown withZValue:8];
        [self createObjectOfType:kSax atLocation:kLocAMSax withZValue:8];
        [self createObjectOfType:kGuitarist atLocation:kLocAMGuitarist withZValue:8];
        
        
        // Create Trigger Object and Ants from textureNode2
        [self createObjectOfType:kCheerleader1 atLocation:kLocAMCheerleader1 withZValue:8];
        [self createObjectOfType:kBee atLocation:kLocFlickBee withZValue:8];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [self createObjectOfType:kSun atLocation:kLocFlickSuniPad withZValue:7];
        }else {
            [self createObjectOfType:kSun atLocation:kLocFlickSun withZValue:7];
        }
//        [self createObjectOfType:kCheerleader2 atLocation:kLocAMCheerleader2 withZValue:8];
//        [self createObjectOfType:kPlane atLocation:kLocFlickPlaneUnTriggered withZValue:8];
        
        
        // Create TV With Child Image Trigger        
        CCMenuItemImage *tvButton = [CCMenuItemImage itemFromNormalImage:@"tvMask.png" selectedImage:@"tvMask.png" target:self selector:@selector(triggerChildVoice)]; 
       
        CCMenu *menu = [CCMenu menuWithItems:tvButton, nil];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){  
            menu.position = ccp(screenSize.width*0.52f,screenSize.height*0.4775f);
        }else{
            menu.position = ccp(screenSize.width*0.52f,screenSize.height*0.475f);
        }
        [self addChild:menu z:2];
        
        [GameManager sharedGameManager].isMusicGameDone = NO;
		self.isTouchEnabled = YES;
        
        [self schedule: @selector(tick:) interval:3.0];
        
	}
	return self;
}

// Function to create different objects in the scene
-(void)createObjectOfType:(GameObjectType)objectType 
               atLocation:(CGPoint)spawnLocation 
               withZValue:(int)ZValue {
    
    if (kGrant == objectType) {
        musicalAnts *mGrant = [[musicalAnts alloc] initWithGameObjectType:objectType];
        [mGrant setPosition:spawnLocation];
        [mGrant setBatchNode:sceneSpriteBatchNode];
        [sceneSpriteBatchNode addChild:mGrant z:ZValue tag:kGrantSpriteTagValue];
        [mGrant release];
    } 
    else if (kAntony == objectType) 
    {
        musicalAnts *mAntony = [[musicalAnts alloc] initWithGameObjectType:objectType];
        [mAntony setPosition:spawnLocation];
        [sceneSpriteBatchNode  addChild:mAntony z:ZValue tag:kAntonySpriteTagValue];
        [mAntony release];
    }
    else if (kSinger == objectType) 
    {
        musicalAnts *mSinger = [[musicalAnts alloc] initWithGameObjectType:objectType];
        [mSinger setPosition:spawnLocation];
        [sceneSpriteBatchNode  addChild:mSinger z:ZValue tag:kSingerSpriteTagValue];
        [mSinger release];
    }
    else if (KDrummer == objectType) 
    {
        musicalAnts *mDrummer = [[musicalAnts alloc] initWithGameObjectType:objectType];
        [mDrummer setPosition:spawnLocation];
        [sceneSpriteBatchNode  addChild:mDrummer z:ZValue tag:KDrummerSpriteTagValue];
        [mDrummer release];
    }
    else if (kTrumpetPlayer == objectType) 
    {
        musicalAnts *mTrumpetPlayer = [[musicalAnts alloc] initWithGameObjectType:objectType];
        [mTrumpetPlayer setPosition:spawnLocation];
        [sceneSpriteBatchNode  addChild:mTrumpetPlayer z:ZValue tag:kTrumpetSpriteTagValue];
        [mTrumpetPlayer release];
    }
    else if(kClown == objectType)
    {
        triggerObjectsAndAnts *mClown = [[triggerObjectsAndAnts alloc] initWithGameObjectType:objectType];
        [mClown setPosition:spawnLocation];
        [triggersSpriteBatchNode  addChild:mClown z:ZValue tag:kClownSpriteTagValue];
        [mClown release];
    }
    else if(kButterfly == objectType)
    {
        triggerObjectsAndAnts *mButterfly = [[triggerObjectsAndAnts alloc] initWithGameObjectType:objectType];
        [mButterfly setPosition:spawnLocation];
        [triggersSpriteBatchNode  addChild:mButterfly z:ZValue tag:kButterflySpriteTagValue];
        [mButterfly release];
    }
    else if(kSax == objectType)
    {
        triggerObjectsAndAnts *mSax = [[triggerObjectsAndAnts alloc] initWithGameObjectType:objectType];
        [mSax setPosition:spawnLocation];
        [triggersSpriteBatchNode  addChild:mSax z:ZValue tag:kSaxSpriteTagValue];
        [mSax release];
    }
    else if(kGuitarist == objectType)
    {
        triggerObjectsAndAnts *mGuitarist = [[triggerObjectsAndAnts alloc] initWithGameObjectType:objectType];
        [mGuitarist setPosition:spawnLocation];
        [triggersSpriteBatchNode  addChild:mGuitarist z:ZValue tag:kGuitaristSpriteTagValue];
        [mGuitarist release];
    }
    else if(kBalloon == objectType)
    {
        triggerObjectsAndAnts *mBalloon = [[triggerObjectsAndAnts alloc] initWithGameObjectType:objectType];
        [mBalloon setPosition:spawnLocation];
        [triggersSpriteBatchNode  addChild:mBalloon z:ZValue tag:kBalloonSpriteTagValue];
        [mBalloon release];
    }
    else if(kGirlOnCloudLeft == objectType)
    {
        triggerObjectsAndAnts *mGirlOnCloudLeft = [[triggerObjectsAndAnts alloc] initWithGameObjectType:objectType];
        [mGirlOnCloudLeft setPosition:spawnLocation];
        [triggersSpriteBatchNode  addChild:mGirlOnCloudLeft z:ZValue tag:kGirlOnCloudLeftSpriteTagValue];
        [mGirlOnCloudLeft release];
    }
    else if(kGirlOnCloudMiddle == objectType)
    {
        triggerObjectsAndAnts *mGirlOnCloudMiddle = [[triggerObjectsAndAnts alloc] initWithGameObjectType:objectType];
        [mGirlOnCloudMiddle setPosition:spawnLocation];
        [triggersSpriteBatchNode  addChild:mGirlOnCloudMiddle z:ZValue tag:kGirlOnCloudMiddleSpriteTagValue];
        [mGirlOnCloudMiddle release];
    }
    else if(kGirlOnCloudRight == objectType)
    {
        triggerObjectsAndAnts *mGirlOnCloudRight = [[triggerObjectsAndAnts alloc] initWithGameObjectType:objectType];
        [mGirlOnCloudRight setPosition:spawnLocation];
        [triggersSpriteBatchNode  addChild:mGirlOnCloudRight z:ZValue tag:kGirlOnCloudRightSpriteTagValue];
        [mGirlOnCloudRight release];
    }
    else if(kBee == objectType)
    {
        triggerObjectsAndAnts *mBee = [[triggerObjectsAndAnts alloc] initWithGameObjectType:objectType];
        [mBee setPosition:spawnLocation];
        [triggersSpriteBatchNodeTwo  addChild:mBee z:ZValue tag:kBeeSpriteTagValue];
        [mBee release];
    }
    else if(kPlane == objectType)
    {
        triggerObjectsAndAnts *mPlane = [[triggerObjectsAndAnts alloc] initWithGameObjectType:objectType];
        [mPlane setPosition:spawnLocation];
        [triggersSpriteBatchNodeTwo  addChild:mPlane z:ZValue tag:kPlaneSpriteTagValue];
        [mPlane setScale:0.75];
        [mPlane release];
    }
    else if(kSun == objectType)
    {
        triggerObjectsAndAnts *mSun = [[triggerObjectsAndAnts alloc] initWithGameObjectType:objectType];
        [mSun setPosition:spawnLocation];
        [triggersSpriteBatchNodeTwo  addChild:mSun z:ZValue tag:kSunSpriteTagValue];
        [mSun release];
    }
    else if(kCheerleader1 == objectType)
    {
        triggerObjectsAndAnts *mCheerleader1 = [[triggerObjectsAndAnts alloc] initWithGameObjectType:objectType];
        [mCheerleader1 setPosition:spawnLocation];
        [triggersSpriteBatchNodeTwo  addChild:mCheerleader1 z:ZValue tag:kCheerleader1SpriteTagValue];
        [mCheerleader1 setScale:0.5];
        [mCheerleader1 release];
    }
    else if(kCheerleader2 == objectType)
    {
        triggerObjectsAndAnts *mCheerleader2 = [[triggerObjectsAndAnts alloc] initWithGameObjectType:objectType];
        [mCheerleader2 setPosition:spawnLocation];
        [triggersSpriteBatchNodeTwo  addChild:mCheerleader2 z:ZValue tag:kCheerleader2SpriteTagValue];
        [mCheerleader2 setScale:0.5];
        [mCheerleader2 release];
    }
}


// Touch Related Stuff
+(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}
+(CGPoint) locationFromTouches:(NSSet*)touches
{
	return [self locationFromTouch:[touches anyObject]];
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[GameManager sharedGameManager].soundEngine stopBackgroundMusic];
}
-(void)switchSceneAndCleanup
{
    if([GameManager sharedGameManager].isMusicGameDone)
    {
        CCArray *listOfGameObjects = [sceneSpriteBatchNode children];
        
        for (musicalAnts *tempChar in listOfGameObjects) 
        {     
            [tempChar setVisible:NO];
            [tempChar removeFromParentAndCleanup:YES];
            [[CCScheduler sharedScheduler] unscheduleUpdateForTarget:tempChar]; 
            [[CCTouchDispatcher sharedDispatcher] removeDelegate:tempChar];
        }
        
        CCArray *listOfGameObjects2 = [triggersSpriteBatchNode children];
        
        for (triggerObjectsAndAnts *tempChar2 in listOfGameObjects2) 
        {                 
            [tempChar2 setVisible:NO];
            [tempChar2 removeFromParentAndCleanup:YES];
            [[CCScheduler sharedScheduler] unscheduleUpdateForTarget:tempChar2]; 
            [[CCTouchDispatcher sharedDispatcher] removeDelegate:tempChar2];
        }
        
        CCArray *listOfGameObjects3 = [triggersSpriteBatchNodeTwo children];
        
        for (triggerObjectsAndAnts *tempChar3 in listOfGameObjects3) 
        {                 
            [tempChar3 setVisible:NO];
            [tempChar3 removeFromParentAndCleanup:YES];
            [[CCScheduler sharedScheduler] unscheduleUpdateForTarget:tempChar3]; 
            [[CCTouchDispatcher sharedDispatcher] removeDelegate:tempChar3];
        }
        
        [sceneSpriteBatchNode removeAllChildrenWithCleanup:YES];
        [triggersSpriteBatchNode removeAllChildrenWithCleanup:YES];
        [triggersSpriteBatchNodeTwo removeAllChildrenWithCleanup:YES];
        
        [GameManager sharedGameManager].didStartThemeSong = NO;
        [GameManager sharedGameManager].isMusicGameDone = NO;

        [[GameManager sharedGameManager] runSceneWithID:kGIAntAudioRecorderScene];
        
        
      // Alt way of removing all characters   
      /*[[CCTouchDispatcher sharedDispatcher] removeDelegate:[triggersSpriteBatchNode getChildByTag:kButterflySpriteTagValue]];
        [triggersSpriteBatchNode removeChildByTag:kButterflySpriteTagValue cleanup:YES];
        
        [[CCTouchDispatcher sharedDispatcher] removeDelegate:[triggersSpriteBatchNode getChildByTag:kBalloonSpriteTagValue]];
        [triggersSpriteBatchNode removeChildByTag:kBalloonSpriteTagValue cleanup:YES];
        
        [[CCTouchDispatcher sharedDispatcher] removeDelegate:[triggersSpriteBatchNode getChildByTag:kGirlOnCloudLeftSpriteTagValue]];
        [triggersSpriteBatchNode removeChildByTag:kGirlOnCloudLeftSpriteTagValue cleanup:YES];
        
        [[CCTouchDispatcher sharedDispatcher] removeDelegate:[triggersSpriteBatchNode getChildByTag:kGirlOnCloudMiddleSpriteTagValue]];
        [triggersSpriteBatchNode removeChildByTag:kGirlOnCloudMiddleSpriteTagValue cleanup:YES];
        
        [[CCTouchDispatcher sharedDispatcher] removeDelegate:[triggersSpriteBatchNode getChildByTag:kGirlOnCloudRightSpriteTagValue]];
        [triggersSpriteBatchNode removeChildByTag:kGirlOnCloudRightSpriteTagValue cleanup:YES];
        
        [[CCTouchDispatcher sharedDispatcher] removeDelegate:[triggersSpriteBatchNode getChildByTag:kClownSpriteTagValue]];
        [triggersSpriteBatchNode removeChildByTag:kClownSpriteTagValue cleanup:YES];
        
        [[CCTouchDispatcher sharedDispatcher] removeDelegate:[triggersSpriteBatchNode getChildByTag:kSaxSpriteTagValue]];
        [triggersSpriteBatchNode removeChildByTag:kSaxSpriteTagValue cleanup:YES];
        
        [[CCTouchDispatcher sharedDispatcher] removeDelegate:[triggersSpriteBatchNode getChildByTag:kGuitaristSpriteTagValue]];
        [triggersSpriteBatchNode removeChildByTag:kGuitaristSpriteTagValue cleanup:YES];
        
        [[CCTouchDispatcher sharedDispatcher] removeDelegate:[triggersSpriteBatchNodeTwo getChildByTag:kCheerleader1SpriteTagValue]];
        [triggersSpriteBatchNodeTwo removeChildByTag:kCheerleader1SpriteTagValue cleanup:YES];
        
        [[CCTouchDispatcher sharedDispatcher] removeDelegate:[triggersSpriteBatchNodeTwo getChildByTag:kBeeSpriteTagValue]];
        [triggersSpriteBatchNodeTwo removeChildByTag:kBeeSpriteTagValue cleanup:YES];
        
        [[CCTouchDispatcher sharedDispatcher] removeDelegate:[triggersSpriteBatchNodeTwo getChildByTag:kSunSpriteTagValue]];
        [triggersSpriteBatchNodeTwo removeChildByTag:kSunSpriteTagValue cleanup:YES];
        
        
        for (triggerObjectsAndAnts *ChildOfNode in [triggersSpriteBatchNode children]) {
            [ChildOfNode setVisible:NO];
            [ChildOfNode removeFromParentAndCleanup:YES];
            [[CCScheduler sharedScheduler] unscheduleUpdateForTarget:ChildOfNode]; 
            [[CCTouchDispatcher sharedDispatcher] removeDelegate:ChildOfNode];
        }
        for (triggerObjectsAndAnts *ChildOfNode in [triggersSpriteBatchNodeTwo children]) {
            [ChildOfNode setVisible:NO];
            [ChildOfNode removeFromParentAndCleanup:YES];
            [[CCScheduler sharedScheduler] unscheduleUpdateForTarget:ChildOfNode]; 
            [[CCTouchDispatcher sharedDispatcher] removeDelegate:ChildOfNode];
        }*/

    }
}

-(void) triggerChildVoice
{
    if (!player.isPlaying){
        [player play];
    }
}

-(void) tick: (ccTime) dt
{
//    if([GameManager sharedGameManager].didStartThemeSong)
//    {
//        CCArray *listOfGameObjects = [triggersSpriteBatchNode children];  
//        
//        for (triggerObjectsAndAnts *tempChar in listOfGameObjects) 
//        {     
//            if (!tempChar.triggerable) {
//                [tempChar changeState:kStateTriggered];
//                [listOfGameObjects removeObject:tempChar];
//            }
//        }
//        
//        for (triggerObjectsAndAnts *tempChar in listOfGameObjects) 
//        {     
//            if (tempChar.triggerable) {
//                [tempChar changeState:kStateUnTriggered];
//            }
//        }
//        
//        //==================================================================
//        
//        
//        CCArray *listOfGameObjects2 = [triggersSpriteBatchNodeTwo children];
//        
//        for (triggerObjectsAndAnts *tempChar in listOfGameObjects2) 
//        {     
//            if (!tempChar.triggerable) {
//                [tempChar changeState:kStateTriggered];
//                [listOfGameObjects2 removeObject:tempChar];
//            }
//        }
//        
//        for (triggerObjectsAndAnts *tempChar in listOfGameObjects2) 
//        {     
//            if (tempChar.triggerable) {
//                [tempChar changeState:kStateUnTriggered];
//            }
//        }
//        
//        // Trigger Something
//        CCArray *listOfGameObjectsCombined = [CCArray array];
//        [listOfGameObjectsCombined addObjectsFromArray:listOfGameObjects];
//        [listOfGameObjectsCombined addObjectsFromArray:listOfGameObjects2];
//        
//        
//        int randomObjectIndex = arc4random() % listOfGameObjectsCombined.count;
//        [(triggerObjectsAndAnts*)[listOfGameObjectsCombined objectAtIndex:randomObjectIndex]  changeState:kStateTriggered];
//    }
}

//-(void) dealloc
//{
//	[super dealloc];
//}
//-(void) onEnter
//{
//	[super onEnter];
//}
//-(void) onEnterTransitionDidFinish
//{
//	[super onEnterTransitionDidFinish];
//}
-(void) onExit
{
    self.isTouchEnabled = NO;
	[super onExit];
}
@end
