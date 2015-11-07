//
//  tprCompetitorDetailViewController.h
//  TallPinesRally
//
//  Created by Derek Vincent on 2014-11-11.
//  Copyright (c) 2014 Derek Vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tprEntryDetailViewController.h"
#import "tprCompetitorResultsViewController.h"

@interface tprCompetitorDetailViewController : UIViewController <UIPageViewControllerDataSource, UINavigationControllerDelegate>

@property (strong, nonatomic) UIPageControl *pageControl; 
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) NSArray *pageViewControllers;
@property (strong, nonatomic) UIPageViewController *pageViewController;


@end
