//
//  PhotoCell.m
//  WildKingdom
//
//  Created by Iván Mervich on 8/7/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "PhotoCell.h"
#import "PhotoCellDetailView.h"

@interface PhotoCell ()

@property (weak, nonatomic) IBOutlet PhotoCellDetailView *detailView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation PhotoCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	self.activityIndicator.alpha = 0;
	[self addSubview:self.activityIndicator];

	return self;
}

- (void)showActivityIndicator
{
	[self.activityIndicator startAnimating];
//	[self addSubview:self.activityIndicator];

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
//			[self.activityIndicator removeFromSuperview];
			//		self.activityIndicator = nil;
		}];
	}
}

- (void)showDetailView
{
	[UIView animateWithDuration:0.5 animations:^{
		self.detailView.alpha = 0.7;
	}];
}

- (void)hideDetailView
{
	[UIView animateWithDuration:0.5 animations:^{
		self.detailView.alpha = 0.0;
	}];
}

- (void)setCountry:(NSString *)country region:(NSString *)region
{
	[self.detailView setCountry:country region:region];
}

- (void)enableUserPhotosButton
{
	[self.detailView enableUserPhotosButton];
}

- (void)setPhotoTitle:(NSString *)title
{
	[self.detailView setPhotoTitle:title];
}

#pragma mark - IBActions

- (IBAction)onLocationButtonPressed:(UIButton *)sender
{
	[self.delegate didTapLocationButtonOnCell:self];
}

- (IBAction)onShowMoreUserPhotosButtonPressed:(UIButton *)sender
{
	[self.delegate didTapShowMoreUserPhotosButtonOnCell:self];
}
@end
