//
//  JPAdvertisementPlaygroundViewController.h
//  JPAdvertisement
//
//  Created by Joe on 5/12/11.
//  Copyright 2011 Joe Pasqualetti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPAdViewController.h"

@interface JPStandInViewController : UIViewController {
    JPAdViewController *adViewC;
}

@property (nonatomic, retain) JPAdViewController *adViewC;

@end
