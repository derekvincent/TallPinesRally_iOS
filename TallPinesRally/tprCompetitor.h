//
//  tprCompetitor.h
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-10-30.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "tprStageResults.h"

@interface tprCompetitor : NSObject

@property (assign, nonatomic) NSInteger id;
@property (strong, nonatomic) NSString* driver;
@property (strong, nonatomic) NSString* codriver;
@property (strong, nonatomic) NSString* car;
@property (strong, nonatomic) NSString* class;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* photo;
@property (strong, nonatomic) NSString* status;
@property (strong, nonatomic) NSString* comment;
@property (assign, nonatomic) NSInteger startorder;
@property (assign, nonatomic) NSInteger carNumber;
@property (assign, nonatomic) NSInteger version;
@property (strong, nonatomic) NSString *bio;
@property (strong, nonatomic) UIImage* teamImage;
@property (assign, nonatomic) NSInteger overallPosition;
@property (strong, nonatomic) NSString *totalTime;
@property (assign, nonatomic) NSInteger classPosition;
@property (strong, nonatomic) NSString *diffLeader;
@property (strong, nonatomic) NSString *diffPrevious;
@property (assign, nonatomic, getter=isDNF) BOOL dnf;
@property (strong, nonatomic) NSString *dnfStage;
@property (strong, nonatomic) NSString *dnfComment;
@property (strong, nonatomic) NSMutableArray *penalties;
@property (strong, nonatomic) NSMutableArray *stageResults;

@property (assign, nonatomic, getter=isWithdrawn) BOOL withdrawn;

-(NSString *)classShorter;
-(NSString *)getStartOrderWithOrdinalSuffix;
-(NSString *)getOverallPoistionWithOrdinalSuffix;
-(NSString *)getPreviousPositionWithOrdinalSuffix; 
-(NSString *)getClassPoistionWithOrdinalSuffix;
-(NSString *)getDNFStageWithOrdinalSuffix;
-(NSString *)getDiffToLeaderFormated;
-(NSString *)getDiffToPreviousFormated;
-(void)addPenalty:(NSString *)penalty control:(NSString *)control remark:(NSString *)remark driverCodriver:(NSString *)driverCodriver;
-(NSArray *)getPenalties;
-(void)addStageResultForStage:(NSString *)stageId stageName:(NSString *)stageName stageLength:(NSString *)stageLength stageTime:(NSString *)stageTime;
-(NSArray *)getResults; 

@end
