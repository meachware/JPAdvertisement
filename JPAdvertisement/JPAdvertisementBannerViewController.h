//
//  JPAdvertisementBannerViewController.h
//  JPAdvertisement
//
//  Created by Joe on 4/26/11.
//  Copyright 2011 Joe Pasqualetti. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const JPAdvertisementHandheldLandscape = @"JPAdvertisementHandheldLandscape";
static NSString *const JPAdvertisementHandheldPortrait = @"JPAdvertisementHandheldPortrait";

@interface JPAdvertisementBannerViewController : UIViewController {
	@private
	IBOutlet UIButton *adButton;
	
	NSURL *adURL, *linkShareURL;
	BOOL affiliatedLink;
	
	NSString *adImageLandscape, *adImagePortrait;

	@public
	NSSet *requiredContentSizeIdentifiers;
	NSString *currentContentSizeIdentifier;
}

@property (nonatomic, retain) UIButton *adButton;

@property (nonatomic, copy) NSURL *adURL, *linkShareURL;
@property (nonatomic, assign) BOOL affiliatedLink;

@property (nonatomic, copy) NSString *adImageLandscape, *adImagePortrait;

@property (nonatomic, copy) NSSet *requiredContentSizeIdentifiers;
@property (nonatomic, copy) NSString *currentContentSizeIdentifier;

//Sizes, in class and instance methods
+ (CGSize) sizeFromBannerContentSizeIdentifier:(NSString *)contentSizeIdentifier;
- (CGSize) sizeFromBannerContentSizeIdentifier:(NSString *)contentSizeIdentifier;

- (BOOL) loadAd;

//Ad tapped action
- (IBAction) adTapped:(UIButton *) sender;

@end
