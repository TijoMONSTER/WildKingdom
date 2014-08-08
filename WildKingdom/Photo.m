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

	self.id = [self.photoInfo[@"id"] stringValue];
	self.owner = [self.photoInfo[@"owner"] stringValue];
	self.secret = [self.photoInfo[@"secret"] stringValue];
	self.server = [self.photoInfo[@"server"] stringValue];
	self.farm = [self.photoInfo[@""] intValue];

	return self;
}

@end
