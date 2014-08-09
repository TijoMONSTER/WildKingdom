//
//  PhotoCellDetailView.m
//  WildKingdom
//
//  Created by Iván Mervich on 8/9/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "PhotoCellDetailView.h"

@interface PhotoCellDetailView ()

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation PhotoCellDetailView

- (void)setCountry:(NSString *)country region:(NSString *)region
{
	if (!country) {
		country = @"Unknown country";
	}
	if (!region) {
		region = @"Unknown region";
	}

	self.locationLabel.text = [NSString stringWithFormat:@"%@, %@", country, region];
}

@end
