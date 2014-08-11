//
//  MapViewController.m
//  WildKingdom
//
//  Created by Iván Mervich on 8/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

#define urlToGetFlickrPhotoLocation @"https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=4d0b397e77019c74a5d42d08253e500a&format=json&nojsoncallback=1&photo_id="
#define flickrLocationDownloadStateOK @"ok"
#define zoomCoordinateSpan 0.9

@interface MapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
	self.tabBarController.tabBar.hidden = YES;
	self.navigationController.navigationBarHidden = NO;

	if (self.photo.location) {
		[self setAnnotation];
		[self zoomToAnnotation];
	} else {
		UIAlertView *alertView = [UIAlertView new];
		alertView.message = @"Can't show photo location.";
		[alertView addButtonWithTitle:@"OK"];
		[alertView show];
	}

	// load the location just once
//	if (!self.photo.location) {
//		[self loadFlickrPhotoLocation];
//	}else {
//	}
}

//- (void)loadFlickrPhotoLocation
//{
//	NSURL *url = [NSURL URLWithString:[urlToGetFlickrPhotoLocation stringByAppendingString:self.photo.photoId]];
//	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//	[NSURLConnection sendAsynchronousRequest:urlRequest
//									   queue:[NSOperationQueue mainQueue]
//						   completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//
//							   NSString *errorMessage;
//
//							   if (!connectionError) {
//								   NSDictionary *decodedJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//
//								   // request status = "ok"
//								   if ([decodedJSON[@"stat"] isEqualToString:flickrLocationDownloadStateOK]) {
//
//									   double latitude = [decodedJSON[@"photo"][@"location"][@"latitude"] doubleValue];
//									   double longitude = [decodedJSON[@"photo"][@"location"][@"longitude"] doubleValue];
//									   self.photo.location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
//									   [self setAnnotation];
//									   [self zoomToAnnotation];
//
//								   } else {
//									   // request status = "fail"
//									   errorMessage = [NSString stringWithFormat:@"Error downloading location for photoID:%@, error code: %d",self.photo.photoId, [decodedJSON[@"code"] intValue]];
//								   }
//							   } else {
//								   errorMessage = connectionError.localizedDescription;
//							   }
//
//							   if (errorMessage) {
//								   UIAlertView *alertView = [UIAlertView new];
//								   alertView.message = errorMessage;
//								   [alertView addButtonWithTitle:@"OK"];
//								   [alertView show];
//								   NSLog(@"%@", errorMessage);
//							   }
//						   }];
//}

- (void)setAnnotation
{
	// get the location
	MKPointAnnotation *annotation = [MKPointAnnotation new];
	annotation.coordinate = self.photo.location.coordinate;
	[self.mapView addAnnotation:annotation];
}

- (void)zoomToAnnotation
{
	MKPointAnnotation *annotation = (MKPointAnnotation *)self.mapView.annotations[0];
	MKCoordinateRegion region;
	region.center = annotation.coordinate;
	region.span = MKCoordinateSpanMake(zoomCoordinateSpan, zoomCoordinateSpan);
	[self.mapView setRegion:region animated:YES];
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
	MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
	return pin;
}

@end
