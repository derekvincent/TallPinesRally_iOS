//
//  tprCompetitorTableCell.h
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-11-03.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tprCompetitorTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *driverNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *codriverNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *carLabel;
@property (nonatomic, weak) IBOutlet UILabel *startOrderLabel; 
@property (nonatomic, weak) IBOutlet UIImageView *teamImageView;

@end
