//
//  PhotoCell.h
//  WildKingdom
//
//  Created by Iván Mervich on 8/7/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;

@end
