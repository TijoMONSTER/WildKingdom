//
//  PhotoCell.m
//  WildKingdom
//
//  Created by Iván Mervich on 8/7/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "PhotoCell.h"

@interface PhotoCell ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation PhotoCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	self.activityIndicator.alpha = 0;

	return self;
}

- (void)showActivityIndicator
{
	[self.activityIndicator startAnimating];
	[self addSubview:self.activityIndicator];

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
			//		self.activityIndicator = nil;
		}];
	}
}

#pragma mark - IBActions

- (IBAction)onPhotoTapped:(UIImageView *)imageView
{

}

@end
