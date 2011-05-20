//
//  JPAdvertisementBannerViewController.m
//  JPAdvertisement
//
//  Created by Joe on 4/26/11.
//  Copyright 2011 Joe Pasqualetti. All rights reserved.
//

#import "JPAdvertisementBannerViewController.h"

CGSize handheldPortraitSize = {320, 50};
CGSize handheldLandscape = {480, 32};


@interface JPAdvertisementBannerViewController ()

- (void) deviceRotated:(id) sender;
- (BOOL) loadAdTextFromPlist:(NSString *) plist;

- (void)openReferralURL:(NSURL *)referralURL;
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

- (void) layoutAdForCurrentOrientation;

@end;


@implementation JPAdvertisementBannerViewController

	@synthesize adButton;

	@synthesize adURL, linkShareURL;
	@synthesize affiliatedLink;

	@synthesize adImagePortrait, adImageLandscape;

	@synthesize requiredContentSizeIdentifiers, currentContentSizeIdentifier;


#pragma mark - Ad Loading

- (BOOL) loadAdTextFromPlist:(NSString *) plist {
	
	NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plist ofType:@"plist"]];
	
	BOOL completeData = YES;
	
	//check for all data keys to have a real value
//	for (NSString *key in [data allKeys]) {
//		if (nil == [data valueForKey:key]) {
//			completeData = NO;
//		}
//	}

	if (completeData) {
		self.adURL = [NSURL URLWithString:[data valueForKey:@"adURL"]];
		self.affiliatedLink = [data valueForKey:@"affiliatedLink"] ? YES : NO;
		self.adImageLandscape = [data valueForKey:@"handheldLandscapeImage"];
		self.adImagePortrait = [data valueForKey:@"handheldPortraitImage"];
		[self layoutAdForCurrentOrientation];
		return YES;
	} else
		return NO;
}

- (BOOL) loadAd {
	return [self loadAdTextFromPlist:@"Grades"];
}


#pragma mark - UI

- (IBAction) adTapped:(UIButton *) sender {
	if (affiliatedLink) {
		[self openReferralURL:adURL];
	} else
		[[UIApplication sharedApplication] openURL:adURL];
}

+ (CGSize) sizeFromBannerContentSizeIdentifier:(NSString *)contentSizeIdentifier {
	if (contentSizeIdentifier == JPAdvertisementHandheldLandscape) {
		return handheldLandscape;
	} else if (contentSizeIdentifier == JPAdvertisementHandheldPortrait) {
		return handheldPortraitSize;
	} else
		return CGSizeZero;
}

- (CGSize) sizeFromBannerContentSizeIdentifier:(NSString *)contentSizeIdentifier {
	return [JPAdvertisementBannerViewController sizeFromBannerContentSizeIdentifier:contentSizeIdentifier];
}

#pragma mark - LinkShare

// Process a LinkShare/TradeDoubler/DGM URL to something iPhone can handle
- (void)openReferralURL:(NSURL *)referralURL {
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:adURL] delegate:self startImmediately:YES];
    [conn release];
}

// Save the most recent URL in case multiple redirects occur
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
    self.linkShareURL = [response URL];
    return request;
}

// No more redirects; use the last URL saved
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [[UIApplication sharedApplication] openURL:self.linkShareURL];
}

#pragma mark - Memory Management

- (id) init {
	self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
	if (self) {
	}
	return self;
}


- (void)dealloc {
	[adButton release], adButton = nil;
	[adURL release];
	[linkShareURL release];
	
	[adImagePortrait release], [adImageLandscape release];
	
	[requiredContentSizeIdentifiers release];
	[currentContentSizeIdentifier release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.autoresizingMask = (UIViewAutoresizingNone);
	
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceRotated:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
	
	[self deviceRotated:self];
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

- (void) viewDidAppear:(BOOL)animated {
	[self layoutAdForCurrentOrientation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void) layoutAdForCurrentOrientation {
	UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
	
	if (UIInterfaceOrientationIsPortrait(orientation)) { //Portrait
		currentContentSizeIdentifier = JPAdvertisementHandheldPortrait;
		[self.adButton setImage:[UIImage imageNamed:adImagePortrait] forState:UIControlStateNormal];
	} 
	else if (UIInterfaceOrientationIsLandscape(orientation)) { //Landscape
		currentContentSizeIdentifier = JPAdvertisementHandheldLandscape;
		[self.adButton setImage:[UIImage imageNamed:adImageLandscape] forState:UIControlStateNormal];
	} else {
		NSLog(@"Error in resizing adView.");
	}
	
	[self.adButton setNeedsDisplay];
}

- (void) deviceRotated:(id) sender {

	[self layoutAdForCurrentOrientation];
	
	CGSize size = [self sizeFromBannerContentSizeIdentifier:currentContentSizeIdentifier];
	CGRect frame = {0,0, size};
	
	[UIView animateWithDuration:.2 animations:^(void) {
		self.view.frame = (CGRect) {self.view.frame.origin, size};
		self.adButton.frame = frame;
	}];
	
}



@end
