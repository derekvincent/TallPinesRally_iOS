//
//  tprPenalty.m
//  TallPinesRally
//
//  Created by Derek Vincent on 2014-11-07.
//  Copyright (c) 2014 Derek Vincent. All rights reserved.
//

#import "tprPenalty.h"

@implementation tprPenalty

-(id)initWithCarNumber:(NSString *)carNumber driverCodriver:(NSString *)driverCodriver class:(NSString *)class control:(NSString *)control remark:(NSString *)remark penalty:(NSString *)penalty
{
    [super self];
    
    if (self)
    {
        self.carNumber = carNumber;
        self.driverCodriver = driverCodriver;
        self.class = class;
        self.control = control;
        self.remark = remark;
        self.penalty = penalty; 
        
    }
    
    return self;
    
}

-(NSString *)getPenaltyFormated
{
    
    NSArray *penaltyArray = [self.penalty componentsSeparatedByString:@":"];
    
    NSString *penaltyFormated;
    if (penaltyArray.count > 2)
    {
        penaltyFormated = [NSString stringWithFormat:@"%@:%@", penaltyArray[1], penaltyArray[2]];
    }
    
    if (!self.penalty)
    {
        penaltyFormated = @"";
    }
    
    return penaltyFormated;
}
@end
