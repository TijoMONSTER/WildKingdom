//
//  Photo.h
//  WildKingdom
//
//  Created by Iván Mervich on 8/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class Photo;
@protocol PhotoDelegate

- (void)locationWasSetForPhoto:(Photo *)photo;
- (void)locationWasNotSetForPhoto:(Photo *)photo withErrorMessage:(NSString *)errorMessage;

@end

@interface Photo : NSObject

@property NSString *photoId;
@property NSString *owner;
@property NSString *secret;
@property NSString *server;
@property int farm;
@property UIImage *image;
@property CLLocation *location;
@property NSString *title;
@property NSString *country;
@property NSString *region;


@property (weak) id<PhotoDelegate> delegate;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary delegate:(id<PhotoDelegate>)delegate;
- (void)loadLocation;
@end
