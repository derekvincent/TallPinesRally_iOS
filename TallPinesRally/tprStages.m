//
//  tprStages.m
//  TallPinesRally
//
//  Created by Derek Vincent on 2014-11-13.
//  Copyright (c) 2014 Derek Vincent. All rights reserved.
//

#import "tprStages.h"

@implementation tprStages

-(void)setCompletedStatus:(NSString *)status
{
    if ([status isEqualToString:@"Completed"]) {
        self.completed = YES;
    } else {
        self.completed = NO;
    }
        
}
@end
