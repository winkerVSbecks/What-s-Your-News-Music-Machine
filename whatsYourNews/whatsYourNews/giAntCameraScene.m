//
//  giAntCameraScene.m
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-06-18.
//  Copyright 2012 winkerVSbecks. All rights reserved.
//

#import "giAntCameraScene.h"


@implementation giAntCameraScene

-(id)init 
{
    self = [super init];
    if (self != nil) 
    { 
        // Interactive Layer: Musical Ants, Musical Object, etc
        cameraLayer *cameraAndPhotoLayer = [cameraLayer node]; 
        [self addChild:cameraAndPhotoLayer z:2];                       
    }
    return self;
}


@end
