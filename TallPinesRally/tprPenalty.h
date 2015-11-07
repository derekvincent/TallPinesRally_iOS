//
//  tprPenalty.h
//  TallPinesRally
//
//  Created by Derek Vincent on 2014-11-07.
//  Copyright (c) 2014 Derek Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tprPenalty : NSObject

@property (strong, nonatomic) NSString *carNumber;
@property (strong, nonatomic) NSString *driverCodriver;
@property (strong, nonatomic) NSString *class;
@property (strong, nonatomic) NSString *control;
@property (strong, nonatomic) NSString *remark;
@property (strong, nonatomic) NSString *penalty;

-(id)initWithCarNumber:(NSString *)carNumber driverCodriver:(NSString *)driverCodriver class:(NSString *)class control:(NSString *)control remark:(NSString *)remark penalty:(NSString *)penalty;

-(NSString *)getPenaltyFormated;

@end
