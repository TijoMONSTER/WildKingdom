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
	}
}

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
