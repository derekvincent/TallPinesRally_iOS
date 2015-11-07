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
@property NSUInteger pageIndex;

@property (strong, nonatomic) IBOutlet UILabel* teamLabel; 
@property (strong, nonatomic) IBOutlet UILabel* driverLabel;
@property (strong, nonatomic) IBOutlet UILabel* codriverLabel;
@property (strong, nonatomic) IBOutlet UILabel* carLabel;
@property (strong, nonatomic) IBOutlet UILabel* classLabel;
@property (strong, nonatomic) IBOutlet UILabel* carNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel* startOrderLabel;
@property (strong, nonatomic) IBOutlet UIImageView* teamImageView;
@property (strong, nonatomic) IBOutlet UITextView* teamDecriptionView;
@property (strong, nonatomic) IBOutlet UILabel* poistionLabel;
@property (strong, nonatomic) IBOutlet UILabel* classPoistionLabel;
@property (strong, nonatomic) IBOutlet UILabel* stageTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel* diffToLeaderLabel;
@property (strong, nonatomic) IBOutlet UILabel* diffToPreviousLabel;
@property (strong, nonatomic) IBOutlet UILabel* dnfLabel;
@property (strong, nonatomic) IBOutlet UILabel* dnfStageLabel;
@property (strong, nonatomic) IBOutlet UILabel* dnfReasonLabel;

@property (strong, nonatomic) IBOutlet UIView* resultsView;
@property (strong, nonatomic) IBOutlet UIView* dnfView;
@end
