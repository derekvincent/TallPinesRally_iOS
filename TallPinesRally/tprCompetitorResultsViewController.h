//
//  tprCompetitorResultsViewController.h
//  TallPinesRally
//
//  Created by Derek Vincent on 2014-11-12.
//  Copyright (c) 2014 Derek Vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tprCompetitor.h"
#import "tprPenalty.h"

@interface tprCompetitorResultsViewController : UITableViewController

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) NSArray *penatlties;
@property (strong, nonatomic) NSArray *results; 
@property NSUInteger pageIndex;

@end
