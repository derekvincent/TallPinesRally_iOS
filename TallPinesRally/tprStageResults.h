//
//  tprStageResults.h
//  TallPinesRally
//
//  Created by Derek Vincent on 2014-11-13.
//  Copyright (c) 2014 Derek Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tprStageResults : NSObject

@property (strong, nonatomic) NSString *stageId;
@property (strong, nonatomic) NSString *stageName;
@property (strong, nonatomic) NSString *stageLength;
@property (strong, nonatomic) NSString *stageTime;

-(id)initWithStageId:(NSString *)stageID stageName:(NSString *)stageName stageLength:(NSString *)stageLength stageTime:(NSString *)stageTime;

-(NSString *)getFormattedStageTime;

@end
