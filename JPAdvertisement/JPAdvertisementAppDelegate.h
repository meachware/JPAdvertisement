//
//  JPAdvertisementAppDelegate.h
//  JPAdvertisement
//
//  Created by Joe on 5/20/11.
//  Copyright 2011 IdiogenicOsmoles & PasquaLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JPAdvertisementViewController;

@interface JPAdvertisementAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet JPAdvertisementViewController *viewController;

@end
