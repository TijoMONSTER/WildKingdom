//
//  PhotoCellDetailView.m
//  WildKingdom
//
//  Created by Iván Mervich on 8/9/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "PhotoCellDetailView.h"

@interface PhotoCellDetailView ()

@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;
@property (weak, nonatomic) IBOutlet UIButton *userPhotosButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation PhotoCellDetailView

- (void)setOwnerName:(NSString *)owner
{
	self.ownerLabel.text = owner;
}

- (void)setPhotoTitle:(NSString *)title
{
	if (!title) {
		title = @"Untitled";
	}
	self.titleLabel.text = title;
}

- (void)enableUserPhotosButton
{
	self.userPhotosButton.enabled = YES;
}

@end
