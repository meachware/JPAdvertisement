//
//  JPAdvertisementPlaygroundViewController.m
//  JPAdvertisement
//
//  Created by Joe on 5/12/11.
/*
 
 http://joepasq.com 
 https://github.com/joepasq
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software in binary form, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "JPStandInViewController.h"

@implementation JPStandInViewController

@synthesize adViewC;

- (void)dealloc
{
	[adViewC release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    [adViewC didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	[super viewDidLoad];

	self.adViewC = [[JPAdViewController alloc] init];
	self.adViewC.view.frame = CGRectMake(0, 70, 320, 50);
	self.adViewC.requiredContentSizeIdentifiers = [NSSet setWithObjects:JPAdvertisementHandheldLandscape, JPAdvertisementHandheldPortrait, nil];
	[self.view addSubview:adViewC.view];
}

- (void) viewWillAppear:(BOOL)animated {
	[adViewC loadAd];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
										 duration:(NSTimeInterval)duration {
//    if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation))
//	{
//		banner.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
//	}
//	else
//	{
//		banner.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
//	}
}

//-(void)layoutForCurrentOrientation:(BOOL)animated {
//	CGFloat animationDuration = animated ? 0.2 : 0.0;
//	// by default content consumes the entire view area
//	CGRect contentFrame = self.view.bounds;
//	// the banner still needs to be adjusted further, but this is a reasonable starting point
//	// the y value will need to be adjusted by the banner height to get the final position
//	CGPoint bannerOrigin = CGPointMake(CGRectGetMinX(contentFrame), CGRectGetMinY(contentFrame));
//	CGFloat bannerHeight = 0.0;
//	
//	// First, setup the banner's content size and adjustment based on the current orientation
//	if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
//		banner.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
//		bannerHeight = 32.0;
//	} else {
//		banner.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
//		bannerHeight = 50.0;
//	}
//	
//	// Depending on if the banner has been loaded, we adjust the content frame and banner location
//	// to accomodate the ad being on or off screen.
//	// This layout is for an ad at the bottom of the view.
//	if(banner.bannerLoaded) {
//		//bannerOrigin.y += bannerHeight;
//		contentFrame.size.height -= bannerHeight;
//		contentFrame.origin.y += bannerHeight;
//	} else {
//		bannerOrigin.y -= bannerHeight;
//	}
//	
//	// And finally animate the changes, running layout for the content view if required.
//	[UIView animateWithDuration:animationDuration
//					 animations:^{
//						 banner.frame = CGRectMake(bannerOrigin.x, bannerOrigin.y, banner.frame.size.width, banner.frame.size.height);
//					 }
//	 ];
//}

@end
