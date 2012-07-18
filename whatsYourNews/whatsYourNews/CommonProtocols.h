//
//  CommonProtocols.h
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-06-06.
//  Copyright (c) 2012 winkerVSbecks. All rights reserved.
//

//  CommonProtocols.h
//  SpaceViking

//************************************************************************
// Tags
//************************************************************************
#define kGrantSpriteTagValue 111
#define kAntonySpriteTagValue 222
#define KDrummerSpriteTagValue 333 
#define kSingerSpriteTagValue 444 
#define kTrumpetSpriteTagValue 555

#define kClownSpriteTagValue 941
#define kBeeSpriteTagValue 942
#define kPlaneSpriteTagValue 943
#define kButterflySpriteTagValue 944
#define kSaxSpriteTagValue 945
#define kGuitaristSpriteTagValue 946
#define kBalloonSpriteTagValue 947
#define kGirlOnCloudLeftSpriteTagValue 948
#define kGirlOnCloudMiddleSpriteTagValue 949
#define kGirlOnCloudRightSpriteTagValue 950
#define kSunSpriteTagValue 951
#define kCheerleader1SpriteTagValue 952
#define kCheerleader2SpriteTagValue 953

#define kAntFlickLayerTagProgressTimer 501

//************************************************************************
// Constants
//************************************************************************
#define kTimeSpriteIsWhackable 1.0
#define kTimeRecordedAudioLength 5.0
#define kNoOfWhacksNeededForWin 12
#define kTimeLimit 30



//************************************************************************
// LOCATIONS iPHONE
//************************************************************************

//Positions of ants
#define kLocGrantIphone ccp(screenSize.width * 0.44f, screenSize.height * 0.18f)
#define kLocAntonyIphone ccp(screenSize.width * 0.25f, screenSize.height * 0.35f)
#define kLocDrummerIphone ccp(screenSize.width * 0.895f, screenSize.height * 0.24f) 
#define kLocSingerIphone ccp(screenSize.width * 0.56f, screenSize.height * 0.12f) 
#define kLocTrumpetIphone ccp(screenSize.width * 0.57f, screenSize.height * 0.29f)

// Audio Mixer Locations
#define kLocAMClown ccp(screenSize.width * 0.07f, screenSize.height * 0.25f)
#define kLocAMSax ccp(screenSize.width * 0.81f, screenSize.height * 0.15f)
#define kLocAMGuitarist ccp(screenSize.width * 0.33f, screenSize.height * 0.1f)
#define kLocAMCheerleader1 ccp(screenSize.width * 0.15f, screenSize.height * 0.18f)
#define kLocAMCheerleader2 ccp(screenSize.width * 0.9f, screenSize.height * 0.38f)

// UnTriggered Locations
#define kLocFlickBeeUnTriggered ccp(screenSize.width * 0.35f, screenSize.height * 1.5)
#define kLocFlickSunUnTriggered ccp(screenSize.width * 0.08f, screenSize.height * 1.5)
#define kLocFlickButterflyUnTriggered ccp(screenSize.width * 0.5f, screenSize.height* 1.5)
#define kLocFlickBalloonUnTriggered ccp(screenSize.width * 0.2f, screenSize.height * 1.5)
#define kLocFlickGirlOnCloudLeftUnTriggered ccp(screenSize.width * 0.70f, screenSize.height * 1.5)
#define kLocFlickGirlOnCloudMiddleUnTriggered ccp(screenSize.width * 0.83f, screenSize.height * 1.5)
#define kLocFlickGirlOnCloudRightUnTriggered ccp(screenSize.width * 0.91f, screenSize.height * 1.5)
#define kLocFlickPlaneUnTriggered ccp(screenSize.width * 0.6f, screenSize.height * 1.5)

// Ant Flick Game Locations
#define kLocFlickClown ccp(screenSize.width * 0.18f, screenSize.height * 0.25f)
#define kLocFlickSax ccp(screenSize.width * 0.84f, screenSize.height * 0.22f)
#define kLocFlickGuitarist ccp(screenSize.width * 0.33f, screenSize.height * 0.1f)
#define kLocFlickCheerleader1 ccp(screenSize.width * 0.45f, screenSize.height * 0.24f)
#define kLocFlickCheerleader2 ccp(screenSize.width * 0.62f, screenSize.height * 0.2f)
#define kLocFlickCheerleader3 ccp(screenSize.width * 0.57f, screenSize.height * 0.14f)
#define kLocFlickBee ccp(screenSize.width * 0.45f, screenSize.height * 0.95)
#define kLocFlickButterfly ccp(screenSize.width * 0.63f, screenSize.height * 1.05)
#define kLocFlickSun ccp(screenSize.width * 0.93f, screenSize.height * 0.75)
#define kLocFlickSuniPad ccp(screenSize.width * 0.93f, screenSize.height * 0.8)
#define kLocFlickBalloon ccp(screenSize.width * 0.77f, screenSize.height * 0.7)
#define kLocFlickGirlOnCloudLeft ccp(screenSize.width * 0.07f, screenSize.height * 1.0)
#define kLocFlickGirlOnCloudMiddle ccp(screenSize.width * 0.2f, screenSize.height * 0.93)
#define kLocFlickGirlOnCloudRight ccp(screenSize.width * 0.3f, screenSize.height * 0.95)
#define kLocFlickPlane ccp(screenSize.width * 0.6f, screenSize.height * 0.8)


//************************************************************************
// Typedef Enums
//************************************************************************
typedef enum {
    kStateIdle,
    kStateAnimated,
    kStateWhackable,
    kStateWhacked,
    kStateTriggered,
    kStateUnTriggered
} CharacterStates;

typedef enum {
    kWhackingStateWhacked,
    kWhackingStateReset
} WhackingState;

typedef enum {
    kGIAnt,
    kAntony,
    kGrant,
    KDrummer,
    kSinger,
    kTrumpetPlayer,
    kClown,
    kBee,
    kPlane,
    kButterfly,
    kSax,
    kGuitarist,
    kBalloon,
    kGirlOnCloudLeft,
    kGirlOnCloudMiddle,
    kGirlOnCloudRight,
    kCheerleader1,
    kCheerleader2,
    kSun,
    kChildTV,
    kObjectTypeNone
} GameObjectType;

typedef enum {
    kNoSceneUninitialized=0,
    kLoadingScene=1,
    kAntFlickScene=101,
    kGIAntAudioRecorderScene=201,
    kGIAntCameraScene=301,
    kAudioMixerScene=401,
} SceneTypes;

@protocol GameplayLayerDelegate
-(void)createObjectOfType:(GameObjectType)objectType 
               atLocation:(CGPoint)spawnLocation 
               withZValue:(int)ZValue;

typedef enum {
    kLinkTypeWYNSite,
    kLinkTypeWinkerVSbecksSite,
    kLinkTypeWoodenGiantSite,
} LinkTypes;


//************************************************************************
// Audio Related Stuff
//************************************************************************
#define AUDIO_MAX_WAITTIME 150

typedef enum {
    kAudioManagerUninitialized=0,
    kAudioManagerFailed=1,
    kAudioManagerInitializing=2,
    kAudioManagerInitialized=100,
    kAudioManagerLoading=200,
    kAudioManagerReady=300
} GameManagerSoundState;

#define SFX_NOTLOADED NO
#define SFX_LOADED YES

#define PLAYSOUNDEFFECT(...) \
[[GameManager sharedGameManager] playSoundEffect:@#__VA_ARGS__]

#define STOPSOUNDEFFECT(...) \
[[GameManager sharedGameManager] stopSoundEffect:__VA_ARGS__]

// Theme Song Layers
#define BEAT_BOX @"Beat Box Stem-Loop.wav"
#define MALE_LOW @"Male Low Stem-Loop.wav"
#define HUMAN_TRUMPETS @"Bahs Human Trumpets Stem-Loop.wav"
#define FEMALE_GROUP @"Females+All Group Stem-Loop.wav"
#define BEEPS @"Beeps Stem-Loop.wav"

//#define ANT_TRUMPET @"Ant Trumpet.wav"
//#define CHIMES @"Chimes.wav"
//#define CRAZY_LAUGH @"Crazy Laugh.wav"
//#define CYMBOL @"Cymbol Crash.wav"
//#define HAPPY_YAY @"Happy Yay.wav"
//#define JINGLE_BELL @"Jingle Bell.wav"
//#define MOUTH_PLOP @"Mouth Plopp.wav"
//#define RASPBERRY @"Rasberry 1.wav"
//#define TABLA @"Tabla.wav"
//#define TAOURINE @"Tambourine.wav"
//#define WOO_HOO @"Whoo Hoo.wav"
//#define YEAH @"Yeah.wav"
//#define YODEL @"Yodel.wav"


#define PTM_RATIO ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 100.0 : 50.0)

@end
