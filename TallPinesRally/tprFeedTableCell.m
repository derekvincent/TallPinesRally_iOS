//
//  tprFeedTableCell.m
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-11-06.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import "tprFeedTableCell.h"

@implementation tprFeedTableCell

@synthesize twTextView = _twTextView;
@synthesize twDate = _twDate;

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
