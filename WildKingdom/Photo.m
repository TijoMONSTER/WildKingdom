//
//  Photo.m
//  WildKingdom
//
//  Created by Iván Mervich on 8/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "Photo.h"

@interface Photo ()

@property NSDictionary *photoInfo;
@end

@implementation Photo

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	self.photoInfo = dictionary;

	self.photoId = self.photoInfo[@"id"];
	self.owner = self.photoInfo[@"owner"];
	self.secret = self.photoInfo[@"secret"];
	self.server = self.photoInfo[@"server"];
	self.farm = [self.photoInfo[@"farm"] intValue];

	return self;
}

@end
