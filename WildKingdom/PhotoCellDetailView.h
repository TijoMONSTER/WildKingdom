//
//  PhotoCellDetailView.h
//  WildKingdom
//
//  Created by Iván Mervich on 8/9/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCellDetailView : UIView

- (void)setCountry:(NSString *)country region:(NSString *)region;
- (void)enableUserPhotosButton;
- (void)setPhotoTitle:(NSString *)title;
@end
