//
//  cameraLayer.m
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-05-30.
//  Copyright 2012 winkerVSbecks. All rights reserved.
//

#import "cameraLayer.h"

@implementation cameraLayer

@synthesize haveImage;
@synthesize giAntTalkAnimation;
@synthesize giAnt;
@synthesize time;
@synthesize loadTicker;

-(id) init
{
	if( (self=[super init])) 
    {
        // BG IMAGE
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"recorderScene.plist"];          
        sceneSpriteBatchNode = 
        [CCSpriteBatchNode batchNodeWithFile:@"recorderScene.png"];
        [self addChild:sceneSpriteBatchNode z:1];
        
        CCSprite *backgroundImage;
        backgroundImage = [CCSprite spriteWithSpriteFrameName:@"recorderBG.png"];
        [backgroundImage setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)]; 
        [sceneSpriteBatchNode addChild:backgroundImage z:2 tag:0];
        
        giAnt = [CCSprite spriteWithSpriteFrameName:@"giAnt_6.png"];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            [giAnt setPosition:ccp(screenSize.width*0.399f, screenSize.height*0.340f)];
        }else {
            [giAnt setPosition:ccp(screenSize.width*0.435f, screenSize.height*0.423f)];
        }
        [sceneSpriteBatchNode addChild:giAnt z:1 tag:9834];
        
        giAntTalkAnimation = [CCAnimation animation];
        [giAntTalkAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_6.png"]];
        [giAntTalkAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_7.png"]];
        [giAntTalkAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_8.png"]];
        [giAntTalkAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_9.png"]];
        [giAntTalkAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_10.png"]];
        [giAntTalkAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_11.png"]];
        [giAntTalkAnimation addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"giAnt_12.png"]];
        [giAntTalkAnimation retain];
        
        id talkAnimationAction = [CCAnimate actionWithDuration:0.5 animation:giAntTalkAnimation restoreOriginalFrame:YES];

        id runAnimations = [CCSequence actions: talkAnimationAction, talkAnimationAction, talkAnimationAction, talkAnimationAction, talkAnimationAction, talkAnimationAction, talkAnimationAction, talkAnimationAction, talkAnimationAction, nil];
        
        [giAnt runAction:runAnimations];
        
        [[GameManager sharedGameManager] playBackgroundTrack:@"pictrueIntro.wav"];
        
        self.haveImage = NO;
        
        self.isTouchEnabled = YES;
	}
	return self;
}

//Based on discussion here: http://www.cocos2d-iphone.org/forum/topic/5734
-(void)pickPhoto:(UIImagePickerControllerSourceType)sourceType
{
    [[CCDirector sharedDirector] pause];
    
    pictureController = [[UIViewController alloc] init];
    [pictureController setView:[[CCDirector sharedDirector] openGLView]]; 
    [pictureController setModalTransitionStyle: UIModalTransitionStyleCoverVertical];
    
    
	UIImagePickerController *picker	= [[UIImagePickerController alloc]init];
    picker.sourceType = sourceType;
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) 
    {
        picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
	picker.delegate = self;
	picker.wantsFullScreenLayout = YES;    
    
    // The media item picker uses the default UI style, so it needs a default-style
    //    status bar to match it visually
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    [pictureController presentModalViewController:picker animated:YES]; 
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // newImage is a UIImage do not try to use a UIImageView
	newImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
	// Dismiss UIImagePickerController and release it
	[picker dismissModalViewControllerAnimated:YES];
	[picker.view removeFromSuperview];
	[picker	release];

    CGSize newSize;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        newSize = CGSizeMake(130.0f*1.33f*2.3, 130.0f*2.3);
    }else {
        newSize = CGSizeMake(130.0f*1.33f, 130.0f);
    }
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [newImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *scalednewImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    
    [sceneSpriteBatchNode removeChildByTag:9834 cleanup:YES];
    
    [self removeChildByTag:1001 cleanup:YES];
    
	CCSprite *imageFromPicker = [CCSprite spriteWithCGImage: scalednewImage.CGImage
														key:nil]; 
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        [imageFromPicker setPosition:ccp(screenSize.width*0.396f, screenSize.height*0.361f)];
    }else {
        [imageFromPicker setPosition:ccp(215, 115)];
    }
    
    if(imageFromPicker!= nil)
    {
        [self addChild: imageFromPicker z:0 tag:1001];
        [[CCDirector sharedDirector] setDeviceOrientation:CCDeviceOrientationLandscapeLeft];
    }
    
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] setDeviceOrientation:CCDeviceOrientationLandscapeLeft];

    
    NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/childsPhotoForTV.png"];
    
    //=============== DELETE OLD FILE
    NSError *error;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *documentsDirectory = [NSHomeDirectory() 
                                    stringByAppendingPathComponent:@"Documents"];
    // Attempt to delete the file at filePath2
    if ([fileMgr removeItemAtPath:pngPath error:&error] != YES)
        NSLog(@"Unable to delete file: %@", [error localizedDescription]);
    
    // Show contents of Documents directory
    NSLog(@"Documents directory: %@",
          [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);
    
    // Write image to PNG
    [UIImagePNGRepresentation(scalednewImage) writeToFile:pngPath atomically:YES];
    
    self.haveImage = YES;
    
    id fancyAudioAndAutoGameStartAction = 
    [CCSequence actions:
     [CCCallBlock actionWithBlock:^(void)
      { 
          [[GameManager sharedGameManager] playBackgroundTrack:@"brilliAnt.wav"];
      }],
     [CCDelayTime actionWithDuration:3.5f],
     [CCCallBlock actionWithBlock:^(void)
      { 
          if(self.haveImage)
          {
              [[GameManager sharedGameManager] runSceneWithID:kAudioMixerScene]; 
          }
      }],
     nil];
    
    
    [self runAction:fancyAudioAndAutoGameStartAction];
}

-(void)recordMethod
{	
    CCLOG(@"Implement image capture Method");
    
    [self pickPhoto:(UIImagePickerControllerSourceTypeCamera)];
    
    //======= Change This to Camera!!!
    //[self pickPhoto:(UIImagePickerControllerSourceTypePhotoLibrary)];
}

- (NSString*) documentsPath
{
	NSArray *searchPaths =
	NSSearchPathForDirectoriesInDomains
	(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* _documentsPath = [searchPaths objectAtIndex: 0];
	[_documentsPath retain];
	
	return _documentsPath;
}

-(NSString *)getUniqueFilenameInFolder:(NSString *)folder forFileExtension:(NSString *)fileExtension {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *existingFiles = [fileManager contentsOfDirectoryAtPath:folder error:nil];
    NSString *uniqueFilename;
    
    do {
        CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
        CFStringRef newUniqueIdString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
        
        uniqueFilename = [[folder stringByAppendingPathComponent:(NSString *)newUniqueIdString] stringByAppendingPathExtension:fileExtension];
        
        CFRelease(newUniqueId);
        CFRelease(newUniqueIdString);
    } while ([existingFiles containsObject:uniqueFilename]);
    
    return uniqueFilename;
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.haveImage)
    {
     [[GameManager sharedGameManager] runSceneWithID:kAudioMixerScene]; 
    }
    else {
        [self recordMethod];
    }
}

- (void) dealloc
{
	[super dealloc];
}

@end
