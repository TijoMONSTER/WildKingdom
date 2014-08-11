//
//  PhotoCell.h
//  WildKingdom
//
//  Created by Iván Mervich on 8/7/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoCell;
@protocol PhotoCellDelegate

- (void)didTapLocationButtonOnCell:(PhotoCell *)cell;
- (void)didTapShowMoreUserPhotosButtonOnCell:(PhotoCell *)cell;

@end

@interface PhotoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property id<PhotoCellDelegate> delegate;
@property BOOL isFlipped;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;
- (void)showDetailView;
- (void)hideDetailView;

- (void)setCountry:(NSString *)country region:(NSString *)region;

@end
