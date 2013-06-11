//
//  tprLocationsViewController.h
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-10-25.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import <UIKit/UIKit.h>

@class tprSpectatorDetailViewController;

NSMutableArray *locationsArray;

@interface tprLocationsViewController : UITableViewController 

@property (strong, nonatomic) tprSpectatorDetailViewController *spectatorDetailViewController; 
@property (retain, atomic) NSMutableArray *locationsArray;

@end
