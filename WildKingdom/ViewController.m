//
//  ViewController.m
//  WildKingdom
//
//  Created by Iván Mervich on 8/7/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ViewController.h"

#define urlToRetrieveFlickrPhotos @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=4d0b397e77019c74a5d42d08253e500a&format=json&nojsoncallback=1&per_page=10&tags="

@interface ViewController ()

@property NSArray *photos;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self loadFlickrPhotosWithKeyword:@"lion"];
}

- (void)loadFlickrPhotosWithKeyword:(NSString *)keyword
{
	NSURL *url = [NSURL URLWithString:[urlToRetrieveFlickrPhotos stringByAppendingString:keyword]];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
	[NSURLConnection sendAsynchronousRequest:urlRequest
									   queue:[NSOperationQueue mainQueue]
						   completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
							   NSDictionary *decodedJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
							   self.photos = decodedJSON[@"photos"][@"photo"];
							   NSLog(@"%@", self.photos);
	}];
}

@end
