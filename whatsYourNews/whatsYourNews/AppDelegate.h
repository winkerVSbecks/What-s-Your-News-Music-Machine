//
//  AppDelegate.h
//  whatsYourNews
//
//  Created by Varun Vachhar on 12-05-28.
//  Copyright winkerVSbecks 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
