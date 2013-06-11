//
//  tprCompetitorTableCell.m
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-11-03.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import "tprCompetitorTableCell.h"

@implementation tprCompetitorTableCell

@synthesize driverNameLabel = _driverNameLabel;
@synthesize codriverNameLabel = _codriverNameLabel;
@synthesize carLabel = _carLabel;
@synthesize startOrderLabel = _startOrderLabel;
@synthesize teamImageView = _teamImageView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
