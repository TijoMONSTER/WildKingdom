//
//  TabBarController.m
//  WildKingdom
//
//  Created by Iván Mervich on 8/7/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "TabBarController.h"
#import "PhotosViewController.h"

@interface TabBarController () <UITabBarControllerDelegate>

@end

@implementation TabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.delegate = self;

	PhotosViewController *lionsViewController = (PhotosViewController *)self.viewControllers[0];
	[lionsViewController loadFlickrPhotosWithKeyword:@"lion"];
}

#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
	PhotosViewController *animalViewController = (PhotosViewController *)viewController;

	// tigers vc
	if ([viewController isEqual: tabBarController.viewControllers[1]]) {
		[animalViewController loadFlickrPhotosWithKeyword:@"tiger"];
	}
	// bears vc
	else if ([viewController isEqual: tabBarController.viewControllers[2]]) {
		[animalViewController loadFlickrPhotosWithKeyword:@"bear"];
	}
}

@end