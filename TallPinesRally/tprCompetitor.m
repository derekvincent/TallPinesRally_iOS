//
//  tprCompetitor.m
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-10-30.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import "tprCompetitor.h"

@implementation tprCompetitor

@synthesize id = _id;
@synthesize driver = _driver;
@synthesize codriver = _codriver;
@synthesize car = _car;
@synthesize class = _class;
@synthesize name = _name;
@synthesize photo = _photo;
@synthesize startorder = _startorder;
@synthesize carNumber = _carNumber;
@synthesize version = _version;
@synthesize status = _status;
@synthesize comment = _comment;
@synthesize teamImage = _teamImage;

-(id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    
    if (self)
    {

    _id = [decoder decodeIntegerForKey:@"id"];
    _driver = [[decoder decodeObjectForKey:@"driver"] copy];
    _codriver = [decoder decodeObjectForKey:@"codriver"];
    _car = [decoder decodeObjectForKey:@"car"];
    _class = [decoder decodeObjectForKey:@"class"];
    _name = [decoder decodeObjectForKey:@"name"];
    _photo = [decoder decodeObjectForKey:@"photo"];
    _startorder = [decoder decodeIntegerForKey:@"startorder"];
    _carNumber = [decoder decodeIntegerForKey:@"carNumber"];
    _version = [decoder decodeIntegerForKey:@"version"];
    _status = [decoder decodeObjectForKey:@"status"];
    _comment = [decoder decodeObjectForKey:@"comment"];
        _bio = [decoder decodeObjectForKey:@"bio"]; 
    //_teamImage = [decoder decodeObjectForKey:@"teamImage"];
    
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeInteger: _id forKey:@"id"];
    [coder encodeObject:_driver forKey:@"driver"];
    [coder encodeObject:_codriver forKey:@"codriver"];
    [coder encodeObject:_car forKey:@"car"];
    [coder encodeObject:_class forKey:@"class"];
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_photo forKey:@"photo"];
    [coder encodeInteger:_startorder forKey:@"startorder"];
    [coder encodeInteger:_carNumber forKey:@"carNumber"];
    [coder encodeInteger:_version forKey:@"version"];
    [coder encodeObject:_status forKey:@"status"];
    [coder encodeObject:_comment forKey:@"comment"];
    [coder encodeObject:_bio forKey:@"bio"];
    //[coder encodeObject:_teamImage forKey:@"teamImage"];
    
}

-(void)totalTime:(NSString *)totalTime
{
    if ([totalTime isEqualToString:@"\"\":\"\":\"\""])
    {
        _totalTime = @"";
    } else {
        _totalTime = totalTime;
    }
}

-(NSString *)classShorter
{
    NSString *shortClass;
    
    if([_class isEqualToString:@"Production 2WD"]) shortClass = @"P2WD";
    if([_class isEqualToString:@"Production 4WD"]) shortClass = @"P4WD";
    if([_class isEqualToString:@"Open 2WD"]) shortClass = @"O2WD";
    if([_class isEqualToString:@"Open 4WD"]) shortClass = @"O4WD";
    if([_class isEqualToString:@"Group 5"]) shortClass = @"G5";
    
    return shortClass; 
}

-(NSString*)ordinalNumberFormat:(NSInteger)num{
    NSString *ending;
    
    int ones = num % 10;
    int tens = floor(num / 10);
    tens = tens % 10;
    if(tens == 1){
        ending = @"th";
    }else {
        switch (ones) {
            case 1:
                ending = @"st";
                break;
            case 2:
                ending = @"nd";
                break;
            case 3:
                ending = @"rd";
                break;
            default:
                ending = @"th";
                break;
        }
    }
    return [NSString stringWithFormat:@"%d%@", num, ending];
}

-(NSString *)getStartOrderWithOrdinalSuffix
{
    
    return [self ordinalNumberFormat:_startorder];
}

-(NSString *)getOverallPoistionWithOrdinalSuffix
{
    NSString *ordianlPosition;
    
    if (_overallPosition == 999) {
        ordianlPosition =@"";
    } else{
        ordianlPosition = [self ordinalNumberFormat:_overallPosition];
    }
    
    return ordianlPosition;
}

-(NSString *)getPreviousPositionWithOrdinalSuffix
{
    NSString *ordianlPosition;
    
    if (_overallPosition == 999) {
        ordianlPosition =@"";
    } else{
        ordianlPosition = [self ordinalNumberFormat:_overallPosition -1];
    }
    
    return ordianlPosition;

}

-(NSString *)getClassPoistionWithOrdinalSuffix
{
    NSString *ordianlPosition;
    
    if (_classPosition == 999) {
        ordianlPosition =@"";
    } else{
        ordianlPosition = [self ordinalNumberFormat:_classPosition];
    }
    
    return ordianlPosition;
}

-(NSString *)getDNFStageWithOrdinalSuffix
{
    return [self ordinalNumberFormat:_dnfStage];
}

-(NSString *)getDiffToLeaderFormated
{
    NSArray *leaderArray = [_diffLeader componentsSeparatedByString:@":"];
    
    NSString *leaderFormated;
    if (leaderArray.count > 2)
    {
        leaderFormated = [NSString stringWithFormat:@"%@:%@", leaderArray[1], leaderArray[2]];
    }
    
    if (!_diffLeader)
    {
        leaderFormated = @"";
    }
    
    return leaderFormated; 
    
}

-(NSString *)getDiffToPreviousFormated
{
    NSArray *prevArray = [_diffPrevious componentsSeparatedByString:@":"];
    
    NSString *prevFormated;
    if (prevArray.count > 2)
    {
        prevFormated = [NSString stringWithFormat:@"%@:%@", prevArray[1], prevArray[2]];
    }
    
    if (!_diffPrevious) {
        prevFormated = @"";
    }
    
    return prevFormated;
}
@end
