//
//  tprCompetitorNewTableCell.h
//  TallPinesRally
//
//  Created by Derek Vincent on 11/6/2013.
//  Copyright (c) 2013 Derek Vincent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tprCompetitorNewTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *driverNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *codriverNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *carLabel;
@property (nonatomic, weak) IBOutlet UILabel *carNumberLabel;
@property (nonatomic, weak) IBOutlet UILabel *classLabel;
@property (nonatomic, weak) IBOutlet UILabel *position;
@property (nonatomic, weak) IBOutlet UILabel *totalTime;
@property (nonatomic, weak) IBOutlet UILabel *diffToLeader;
@property (nonatomic, weak) IBOutlet UILabel *diffToPrevious;
@property (nonatomic, weak) IBOutlet UIImageView *backgroundCircle;

@end
