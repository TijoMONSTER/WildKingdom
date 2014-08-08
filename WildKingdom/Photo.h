//
//  Photo.h
//  WildKingdom
//
//  Created by Iván Mervich on 8/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property NSString id;
@property NSString owner;
@property NSString secret;
@property NSString server;
@property int farm;
@property UIImage image;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
