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

	UINavigationController *childNavController = (UINavigationController *)self.viewControllers[0];
	PhotosViewController *lionsViewController = (PhotosViewController *)childNavController.viewControllers[0];
	[lionsViewController loadFlickrPhotosWithKeyword:@"lions,wild"];
}

#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
	UINavigationController *navController = (UINavigationController *)viewController;

	PhotosViewController *photosViewController = (PhotosViewController *)navController.viewControllers[0];
	NSString *keyword;

	// tigers vc
	if ([viewController isEqual: tabBarController.viewControllers[1]]) {
		keyword = @"tigers,wild";
	}
	// bears vc
	else if ([viewController isEqual: tabBarController.viewControllers[2]]) {
		keyword = @"bears,wild";
	}

	[photosViewController loadFlickrPhotosWithKeyword:keyword];
	[photosViewController adjustFlowLayout];
}

@end