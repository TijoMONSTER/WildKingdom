//
//  UserPhotosViewController.m
//  WildKingdom
//
//  Created by Iván Mervich on 8/10/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "UserPhotosViewController.h"

#define urlToRetrieveUserFlickrPhotos @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=4d0b397e77019c74a5d42d08253e500a&format=json&nojsoncallback=1&user_id="

@interface UserPhotosViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation UserPhotosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = NO;
	self.tabBarController.tabBar.hidden = YES;

	if (self.photo.userPhotosURL) {
		[self loadUserPhotosURL];
	} else {
		UIAlertView *alertView = [UIAlertView new];
		alertView.message = @"Can't show user photos, URL not set.";
		[alertView addButtonWithTitle:@"OK"];
		[alertView show];
	}
}

- (void)loadUserPhotosURL
{
	NSURL *url = [NSURL URLWithString:self.photo.userPhotosURL];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[self showActivityIndicator];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[self hideActivityIndicator];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	UIAlertView *alertView = [UIAlertView new];
	alertView.title = @"Error!";
	alertView.message = error.localizedDescription;
	[alertView addButtonWithTitle:@"OK"];
	[alertView show];
	[self hideActivityIndicator];
}

#pragma mark - Helper methods

- (void)showActivityIndicator
{
	[self.activityIndicator startAnimating];
	[self.view addSubview:self.activityIndicator];
	self.activityIndicator.alpha = 0;

	[UIView animateWithDuration:1.0 animations:^{
		self.activityIndicator.alpha = 1;
	}];
}

- (void)hideActivityIndicator
{
	if (self.activityIndicator.alpha != 0) {
		[UIView animateWithDuration:1.0 animations:^{
			self.activityIndicator.alpha = 0;
		} completion:^(BOOL finished) {
			[self.activityIndicator stopAnimating];
			[self.activityIndicator removeFromSuperview];
		}];
	}
}

@end
