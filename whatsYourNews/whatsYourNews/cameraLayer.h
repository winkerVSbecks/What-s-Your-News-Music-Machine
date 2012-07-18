//
//  cameraLayer.h
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-05-30.
//  Copyright 2012 winkerVSbecks. All rights reserved.
//

/***********************************************************************************************
 
 # CAMERA LAYER
 
 - Some sort of an UIImagePickerController implementation

 ## References:
     > https://developer.apple.com/library/ios/#documentation/uikit/reference/UIImagePickerController_Class/UIImagePickerController/UIImagePickerController.html
     > http://www.raywenderlich.com/3997/introduction-to-augmented-reality-on-the-iphone
     > http://stackoverflow.com/questions/9669856/iphone-camera-image-in-cocos2d
     > http://zcentric.com/2008/08/28/using-a-uiimagepickercontroller/
    
 
 ***********************************************************************************************/

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameManager.h"

@interface cameraLayer : CCLayer<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIWindow *window;
	UIImage *newImage;
    UIViewController *pictureController;
    
    bool haveImage;

    bool continueToNextScene;
    
    CCSpriteBatchNode *sceneSpriteBatchNode;
    
    CCAnimation *giAntTalkAnimation;
    
    CCSprite *giAnt;
    
    CCProgressTimer *timer;
    float time;
    float loadTicker;
}

@property (nonatomic, readwrite)bool haveImage;
@property(nonatomic, retain)CCAnimation *giAntTalkAnimation;
@property(nonatomic, retain)CCSprite *giAnt;
@property (nonatomic,readwrite) float time;
@property (nonatomic,readwrite) float loadTicker;

@end
