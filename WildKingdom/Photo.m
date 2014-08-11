//
//  Photo.m
//  WildKingdom
//
//  Created by Iván Mervich on 8/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "Photo.h"

#define urlToGetUserPhotosURL @"https://api.flickr.com/services/rest/?method=flickr.urls.getUserPhotos&api_key=4d0b397e77019c74a5d42d08253e500a&format=json&nojsoncallback=1&user_id="
#define flickrDownloadStateOK @"ok"

@interface Photo ()

@property NSString *imageURLString;

@end

@implementation Photo

- (instancetype)initWithDictionary:(NSDictionary *)dictionary delegate:(id<PhotoDelegate>)delegate
{
	self = [super init];

	self.photoId = dictionary[@"id"];
	self.owner = dictionary[@"owner"];
	self.secret = dictionary[@"secret"];
	self.server = dictionary[@"server"];
	self.farm = [dictionary[@"farm"] intValue];
	self.title = dictionary[@"title"];
	self.imageURLString = dictionary[@"url_z"];
	self.ownerName = dictionary[@"ownername"];

	double latitude = [dictionary[@"latitude"] doubleValue];
	double longitude = [dictionary[@"longitude"] doubleValue];
	self.location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];

	self.delegate = delegate;

	return self;
}

- (void)downloadImage
{
	if (self.image) {
		[self.delegate imageWasSetForPhoto:self atIndexPath:self.indexPath];
	}

	NSURL *url = [NSURL URLWithString:self.imageURLString];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
	[NSURLConnection sendAsynchronousRequest:urlRequest
									   queue:[NSOperationQueue mainQueue]
						   completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

							   if (!connectionError) {
								   self.image = [UIImage imageWithData:data];
								   [self.delegate imageWasSetForPhoto:self atIndexPath:self.indexPath];
							   }
							   // connection error
							   else {
								   [self.delegate imageWasNotSetForPhoto:self withErrorMessage:connectionError.localizedDescription];
							   }
						   }];
}

- (void)loadOtherPhotosFromUserURL
{
	// load user photos only once
	if (self.userPhotosURL) {
		[self.delegate userPhotosURLWasSetForPhoto:self];
		return;
	}

	NSURL *url = [NSURL URLWithString:[urlToGetUserPhotosURL stringByAppendingString:self.owner]];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
	[NSURLConnection sendAsynchronousRequest:urlRequest
									   queue:[NSOperationQueue mainQueue]
						   completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

							   NSString *errorMessage;

							   if (!connectionError) {
								   NSDictionary *decodedJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

								   // request status = "ok"
								   if ([decodedJSON[@"stat"] isEqualToString:flickrDownloadStateOK]) {

									   self.userPhotosURL = decodedJSON[@"user"][@"url"];
									   [self.delegate userPhotosURLWasSetForPhoto:self];

								   }
								   // request status = "fail"
								   else {
									   errorMessage = [NSString stringWithFormat:@"Error downloading user photos url for photoID:%@, owner:%@, error code: %d",self.photoId, self.owner, [decodedJSON[@"code"] intValue]];
								   }
							   }
							   // connection error
							   else {
								   errorMessage = connectionError.localizedDescription;
							   }

							   if (errorMessage) {
								   [self.delegate userPhotosURLWasNotSetForPhoto:self withErrorMessage:errorMessage];
							   }
						   }];
}


@end