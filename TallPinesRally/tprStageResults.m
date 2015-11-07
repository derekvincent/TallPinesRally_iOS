//
//  tprStageResults.m
//  TallPinesRally
//
//  Created by Derek Vincent on 2014-11-13.
//  Copyright (c) 2014 Derek Vincent. All rights reserved.
//

#import "tprStageResults.h"

@implementation tprStageResults

-(id)initWithStageId:(NSString *)stageID stageName:(NSString *)stageName stageLength:(NSString *)stageLength stageTime:(NSString *)stageTime
{

    self = [super self];
    if (self)
    {
        self.stageId = stageID;
        self.stageName = stageName;
        self.stageLength = stageLength;
        self.stageTime = stageTime;
    }
    
    return self;
    
}

-(NSString *)getFormattedStageTime
{
    NSArray *stageTimeArray = [self.stageTime componentsSeparatedByString:@":"];
    
    NSString *stageTimeFormated;
    if (stageTimeArray.count > 2)
    {
        stageTimeFormated = [NSString stringWithFormat:@"%@:%@", stageTimeArray[1], stageTimeArray[2]];
    }
    
    if (!self.stageTime)
    {
        stageTimeFormated = @"";
    }
    
    return stageTimeFormated;
}
@end
