//
//  Photo.m
//  WildKingdom
//
//  Created by Iván Mervich on 8/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "Photo.h"

#define urlToGetFlickrPhotoLocation @"https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=4d0b397e77019c74a5d42d08253e500a&format=json&nojsoncallback=1&photo_id="
#define flickrDownloadStateOK @"ok"

#define urlToGetUserPhotosURL @"https://api.flickr.com/services/rest/?method=flickr.urls.getUserPhotos&api_key=4d0b397e77019c74a5d42d08253e500a&format=json&nojsoncallback=1&user_id="

@interface Photo ()

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

	self.delegate = delegate;

	return self;
}

- (void)loadLocation
{
	// load location only once
	if (self.location) {
		[self.delegate locationWasSetForPhoto:self];
		return;
	}

	NSURL *url = [NSURL URLWithString:[urlToGetFlickrPhotoLocation stringByAppendingString:self.photoId]];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
	[NSURLConnection sendAsynchronousRequest:urlRequest
									   queue:[NSOperationQueue mainQueue]
						   completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

							   NSString *errorMessage;

							   if (!connectionError) {
								   NSDictionary *decodedJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

								   // request status = "ok"
								   if ([decodedJSON[@"stat"] isEqualToString:flickrDownloadStateOK]) {

									   NSDictionary *location = decodedJSON[@"photo"][@"location"];
									   double latitude = [location[@"latitude"] doubleValue];
									   double longitude = [location[@"longitude"] doubleValue];
									   self.location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];

									   self.country = location[@"country"][@"_content"];
									   self.region = location[@"region"][@"_content"];

									   [self.delegate locationWasSetForPhoto:self];
								   }
								   // request status = "fail"
								   else {
									   errorMessage = [NSString stringWithFormat:@"Error downloading location for photoID:%@, error code: %d",self.photoId, [decodedJSON[@"code"] intValue]];
								   }
							   }
							   // connection error
							   else {
								   errorMessage = connectionError.localizedDescription;
							   }

							   if (errorMessage) {
								   [self.delegate locationWasNotSetForPhoto:self withErrorMessage:errorMessage];
							   }
						   }];
}


- (void)loadOtherPhotosFromUserURL
{
	// load location only once
	if (self.userPhotosURL) {
//		[self.delegate userPhotosURLWasSetForPhoto:self];
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