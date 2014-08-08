//
//  PhotoCell.m
//  WildKingdom
//
//  Created by Iván Mervich on 8/7/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "PhotoCell.h"

@interface PhotoCell ()

@property UIActivityIndicatorView *activityIndicator;

@end

@implementation PhotoCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];

	self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	self.activityIndicator.center = self.center;
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
	[UIView animateWithDuration:1.0 animations:^{
		self.activityIndicator.alpha = 0;
	} completion:^(BOOL finished) {
		[self.activityIndicator stopAnimating];
		[self.activityIndicator removeFromSuperview];
		self.activityIndicator = nil;
	}];
}

@end
