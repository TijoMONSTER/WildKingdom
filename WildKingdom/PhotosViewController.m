//
//  ViewController.m
//  WildKingdom
//
//  Created by Iván Mervich on 8/7/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoCell.h"
#import "MapViewController.h"
#import "Photo.h"

#define urlToRetrieveFlickrPhotos @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=4d0b397e77019c74a5d42d08253e500a&format=json&nojsoncallback=1&license=1,2,3&per_page=10&tags="

@interface PhotosViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property NSMutableArray *photos;
@property NSArray *photosJSON;
@property NSMutableDictionary *cachedPhotos;

@property UICollectionViewFlowLayout *flowLayout;

@end

@implementation PhotosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.photos = [NSMutableArray new];

	self.flowLayout = [UICollectionViewFlowLayout new];
	self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	[self adjustFlowLayout];
}

- (void)adjustFlowLayout
{
	UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;

	if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
		self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		// change scroll direction to horizontal
		flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		self.collectionView.alwaysBounceVertical = NO;
		self.collectionView.alwaysBounceHorizontal = YES;
		self.collectionView.showsVerticalScrollIndicator = NO;
		self.collectionView.showsHorizontalScrollIndicator = YES;
	} else {
		// change scroll direction to vertical
		flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
		self.collectionView.alwaysBounceVertical = YES;
		self.collectionView.alwaysBounceHorizontal = NO;
		self.collectionView.showsVerticalScrollIndicator = YES;
		self.collectionView.showsHorizontalScrollIndicator = NO;
	}
}

- (void)loadFlickrPhotosWithKeyword:(NSString *)keyword
{
	// don't load it a second time
	if (self.photosJSON != nil) {
		return;
	}

	NSURL *url = [NSURL URLWithString:[urlToRetrieveFlickrPhotos stringByAppendingString:keyword]];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
	[NSURLConnection sendAsynchronousRequest:urlRequest
									   queue:[NSOperationQueue mainQueue]
						   completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

							   if (!connectionError) {
								   NSDictionary *decodedJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
								   
								   NSArray *photosJSON = decodedJSON[@"photos"][@"photo"];
								   for (NSDictionary *photoJSON in photosJSON) {
									   Photo *photo = [[Photo alloc] initWithDictionary:photoJSON];
									   [self.photos addObject:photo];
								   }
								   [self.collectionView reloadData];
							   } else {
								   UIAlertView *alertView = [UIAlertView new];
								   alertView.message = connectionError.localizedDescription;
								   [alertView addButtonWithTitle:@"OK"];
								   [alertView show];
							   }
	}];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return [self.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	PhotoCell *cell = (PhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];

	cell.imageView.image = nil;

	Photo *photo = self.photos[indexPath.row];

	// load image
	if (!photo.image) {
		NSString *imageURLString = [NSString stringWithFormat:@"https://farm%d.staticflickr.com/%@/%@_%@.jpg", photo.farm, photo.server, photo.photoId, photo.secret];

		[cell showActivityIndicator];

		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul), ^{

			NSURL *imageURL = [NSURL URLWithString:imageURLString];
			NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
			UIImage *image = [UIImage imageWithData:imageData];

			dispatch_async(dispatch_get_main_queue(), ^{
				photo.image = image;
				cell.imageView.image = photo.image;

				[cell hideActivityIndicator];
			});
		});
	} else {
		// show the cached image
		cell.imageView.image = photo.image;
	}

	return cell;
}

#pragma mark - UICollectionViewDelegate

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//	NSLog(@"tapped cell index %d", indexPath.row);
//}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"showLocationInMapSegue"]) {
		MapViewController *mapVC = (MapViewController *)segue.destinationViewController;
		
	}
}

@end
