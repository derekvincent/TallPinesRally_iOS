//
//  tprEntryDetailViewController.h
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-11-03.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tprEntryDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel* teamLabel; 
@property (strong, nonatomic) IBOutlet UILabel* driverLabel;
@property (strong, nonatomic) IBOutlet UILabel* codriverLabel;
@property (strong, nonatomic) IBOutlet UILabel* carLabel;
@property (strong, nonatomic) IBOutlet UILabel* classLabel;
@property (strong, nonatomic) IBOutlet UILabel* carNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel* startOrderLabel;
@property (strong, nonatomic) IBOutlet UIImageView* teamImageView;
@property (strong, nonatomic) IBOutlet UITextView* teamDecriptionView; 

@end
