//
//  tprStages.h
//  TallPinesRally
//
//  Created by Derek Vincent on 2014-11-13.
//  Copyright (c) 2014 Derek Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tprStages : NSObject


@property (strong, nonatomic) NSString *stageId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *stageLength;
@property (strong, nonatomic) NSString *resultFilename;
@property (assign, nonatomic, getter=isCompleted) BOOL completed;


-(void)setCompletedStatus:(NSString *)status;

@end
