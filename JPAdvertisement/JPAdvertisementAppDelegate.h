//
//  JPAdvertisementAppDelegate.h
//  JPAdvertisement
//
//  Created by Joe on 5/20/11.
//  Copyright 2011 Joe Pasqualetti. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JPStandInViewController;

@interface JPAdvertisementAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet JPStandInViewController *viewController;

@end
