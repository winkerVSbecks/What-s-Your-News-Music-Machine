//
//  tvSetBGLayer.m
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-05-30.
//  Copyright 2012 winkerVSbecks. All rights reserved.
//

#import "tvSetBGLayer.h"
#import "GameManager.h"


@implementation tvSetBGLayer
-(id)init 
{ 
    self = [super init];                                   
    if (self != nil) 
    {                                           
        CCSprite *backgroundImage;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        backgroundImage = [CCSprite spriteWithFile:@"audioMixerBG.png"];
        
        [backgroundImage setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)]; 
        [self addChild:backgroundImage z:1 tag:0];
        
        NSString  *pngPathForSavedChildImage = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/childsPhotoForTV.png"];
        
        
        //=============== DELETE OLD FILE
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        
        // Attempt to delete the file at filePath2
        if ([fileMgr isReadableFileAtPath:pngPathForSavedChildImage] != YES)
        {
            CCSprite *tvFiller = [CCSprite spriteWithFile:@"tvAlt.png"];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
                [tvFiller setPosition:CGPointMake(screenSize.width * 0.521, screenSize.height * 0.444)];
            }else {
                [tvFiller setPosition:CGPointMake(screenSize.width * 0.521, screenSize.height * 0.434)];
            }
            [self addChild:tvFiller z:1];
        }
        //=============== END DELETE OLD FILE
        else 
        {
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:pngPathForSavedChildImage]];

            CCSprite *SpriteFromUIImage = [CCSprite spriteWithCGImage:[image CGImage] key:nil];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
                [SpriteFromUIImage setPosition:CGPointMake(screenSize.width * 0.52, screenSize.height*0.4)];
            }else {
                [SpriteFromUIImage setPosition:CGPointMake(screenSize.width * 0.52, screenSize.height/2)];
            }
            [self addChild:SpriteFromUIImage z:0 tag:0];
        }
    }
    return self;                                                   
}

@end
