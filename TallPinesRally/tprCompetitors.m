//
//  tprCompetitors.m
//  TallPinesRally
//
//  Created by Derek Vincent on 10/31/2013.
//  Copyright (c) 2013 Derek Vincent. All rights reserved.
//

#import "tprCompetitors.h"
#import "tprCompetitor.h"
#import "RXMLElement.h"
#import "Utillities.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@implementation tprCompetitors

+(NSString *)getStorageLocation
{
    // Set the Default path to the application Library directory
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    // Use the specific rtpObjectStorage directory in the Library directory
    NSString *storagePath = [[path objectAtIndex:0] stringByAppendingPathComponent:@"rtpObjectStorage"];
    
    // Check if the path exisits and if not create the directory structure
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:storagePath] == NO)
    {
        [fileManager createDirectoryAtPath:storagePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    // Return the directory path with the file name competitors to be used by the archiver
    return [storagePath stringByAppendingPathComponent:@"competitors"];
    
}

-(void)loadCompetitorsFromStorage
{
    // Pull the archived array object out of the file and load them into the property
    _competitors = [[NSKeyedUnarchiver unarchiveObjectWithFile:[tprCompetitors getStorageLocation]] mutableCopy];
    
}
-(void)loadCompetitorsFromWeb
{
    //TODO: Impliment the web service call to fetch the data from the website.
    
    //NSURL *urlCompetitors = [NSURL URLWithString:@"http://tallpinesrally.com/compete/entrylist?xml=1"];
    //NSURL *urlCompetitors = [NSURL URLWithString:@"http://tallpinesrally.com/compete/entrylist?xml=1&event_id=5"];
    //NSURL *urlOverallResults = [NSURL URLWithString:@"http://kemikal.net/stOver.xml"];
    //NSURL *urlRetirements = [NSURL URLWithString:@"http://kemikal.net/retirement.xml"];
   // NSURL *urlOverallResults = [NSURL URLWithString:@"http://rallyscoring.com/results/2013/TallPines/stOver.xml"];
   // NSURL *urlRetirements = [NSURL URLWithString:@"http://rallyscoring.com/results/2013/TallPines/retirement.xml"];
    
    bool testingMode = YES;
    
    NSURL *urlCompetitors;      // Webservice call for Competitors from TallPines entry list
    NSURL *urlStages;           // Stage detail summary summary.xml file from Rallyscoring
    NSURL *urlOverallResults;   // Overall results stOver.xml from RallyScoring
    NSURL *urlRetirements;      // DNF information from retirments.xml from RallyScoring
    NSURL *urlPenalties;        // Penalty information from penatly.xml from Rallyscoring
    NSString *baseDetailURL;    // Base url for stage results details stXX.xml from Rally scoring
    
    if (testingMode)
    {
        urlCompetitors = [NSURL URLWithString:@"http://tallpinesrally.com/compete/entrylist?xml=1&event_id=6"];
        urlStages = [NSURL URLWithString:@"http://rallyscoring.com/results/2014/TallPines/summary.xml"];
        urlOverallResults = [NSURL URLWithString:@"http://rallyscoring.com/results/2014/TallPines/stOver.xml"];
        urlRetirements = [NSURL URLWithString:@"http://rallyscoring.com/results/2014/TallPines/retirement.xml"];
        urlPenalties = [NSURL URLWithString:@"http://rallyscoring.com/results/2014/TallPines/penalty.xml"];
        baseDetailURL = @"http://rallyscoring.com/results/2014/TallPines";
        
    } else {
        
        urlCompetitors = [NSURL URLWithString:@"http://tallpinesrally.com/compete/entrylist?xml=1"];
        urlStages = [NSURL URLWithString:@"http://rallyscoring.com/results/2015/TallPines/summary.xml"];
        urlOverallResults = [NSURL URLWithString:@"http://rallyscoring.com/results/2015/TallPines/stOver.xml"];
        urlRetirements = [NSURL URLWithString:@"http://rallyscoring.com/results/2015/TallPines/retirement.xml"];
        urlPenalties = [NSURL URLWithString:@"http://rallyscoring.com/results/2015/TallPines/penalty.xml"];
        baseDetailURL = @"http://rallyscoring.com/results/2015/TallPines";
        
    }
                               
    
    dispatch_async(kBgQueue, ^{
        
        //work in the background
        //BOOL networkIssues;
        
        NSError* competitorError = nil;
        
        NSData *competitorData = [NSData dataWithContentsOfURL:urlCompetitors
                                             options:NSDataReadingMappedIfSafe
                                               error:&competitorError];
        if (competitorError == nil)
        {
            
            RXMLElement *xml = [RXMLElement elementFromXMLData:competitorData];
            
            NSArray* teams = [xml children:@"team"];
            
            NSMutableArray* result = [NSMutableArray arrayWithCapacity:teams.count];
            
            for (RXMLElement *e in teams) {
                
                //iterate over the articles
                tprCompetitor* team = [[tprCompetitor alloc] init];
                team.id         = [[e child:@"id"] textAsInt];
                team.driver     = [[e child:@"driver"] text];
                team.codriver   = [[e child:@"codriver"] text];
                team.car        = [[e child:@"car"] text];
                team.class      = [[e child:@"class"] text];
                team.name       = [[e child:@"name"] text];
                team.photo      = [[e child:@"photo"] text];
                team.startorder = [[e child:@"startorder"] textAsInt];
                team.carNumber  = [[e child:@"carnumber"] textAsInt];
                team.version    = [[e child:@"version"] textAsInt];
                team.status     = [[e child:@"status"] text];
                team.comment    = [[e child:@"comment"] text];
                team.bio        = [[e child:@"bio"] text];
          
                
                if ([team.status isEqualToString:@"Withdrawn"]) {
                    team.withdrawn = TRUE;
                    //team.startorder = 900 + team.carNumber;
                }
                
                //NSLog(@"Competitor %i Driver: %@ coDriver %@", team.id, team.driver, team.codriver);
                // If the start order of a single team is greater then 0 the we have  starting order... 
                if (team.startorder > 0) _startingOrder = TRUE;
                [result addObject: team];
            }
            
            // Save the result set to the main muttable array
            _competitors = result;
            
            //Should be saving it to the NSCODER? when working?
            //[self saveCompetitorsToStorage];
            // Call this one we have created the Competitors object - important!!!!
            //networkIssues = TRUE;
            
            
            NSError *resultSetError = nil;
            
            NSData *resultSetData = [NSData dataWithContentsOfURL:urlStages
                                                          options:NSDataReadingMappedIfSafe
                                                            error:&resultSetError];
            
            if (resultSetError == nil) {
                
                RXMLElement *xml = [RXMLElement elementFromXMLData:resultSetData];
                NSArray *resultSet = [xml children:@"stage"];
                
                for (RXMLElement *e in resultSet) {
                    NSString *stageId = [[e child:@"id"] text];
                    NSString *name    = [[e child:@"name"] text];
                    NSString *length  = [[e child:@"length"] text];
                    NSString *results = [[e child:@"results"] text];
                    NSString *completed = [[e child:@"completed"] text];
                    
                    [self setStageDetailsWithID:stageId
                                           name:name
                                         length:length
                                     resultFile:results
                                      completed:completed];
                }
            }
            
            // Once we have the competitors we check for the results...
            //We can only do this if we have competitors since we need them to map the results to
            
            NSError* resultError = nil;
            
            NSData *resultsData = [NSData dataWithContentsOfURL:urlOverallResults
                                                        options:NSDataReadingMappedIfSafe
                                                          error:&resultError];
            if (resultError == nil)
            {
                
                RXMLElement *xml = [RXMLElement elementFromXMLData:resultsData];
                
                NSArray* results = [xml children:@"result"];
                
                for (RXMLElement *e in results) {
                    
                    NSInteger carNumber = [[e child:@"number"] textAsInt];
                    NSInteger position = [[e child:@"position"] textAsInt];
                    NSInteger classPosition = [[e child:@"classPosition"] textAsInt];
                    NSString *totalTime = [[e child:@"totalTime"] text];
                    NSString *diffLeader = [[e child:@"diffLeader"] text];
                    NSString *diffPrev = [[e child:@"diffPrev"] text];
                    
                    [self setOverallResultsWithCarNumber:carNumber Position:position ClassPosition:classPosition TotalTime:totalTime DifferenceToLeader:diffLeader DifferenceToPreviousCompetitor:diffPrev];
                    
                };
                // IF we made it here without error we have results!
                _results = TRUE;
               
            }
            else
            {
                //If we are here then we do not have results for one reason or another... but should not error out...
                _results = FALSE;
                //NSLog(@"Error fetching Network Data. Code: %i  Message: %@", callError.code, callError.description);
            }
            
            // We will iterate over all compeleted stages and grab the results for each stage
            
            for (tprStages *stageDetail in self.stages)
            {
                NSError* stageDetailsError = nil;
                
                if (stageDetail.isCompleted) {
                    
                    NSURL *stageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", baseDetailURL, stageDetail.resultFilename]];
                    
                    NSData *stageResultData = [NSData dataWithContentsOfURL:stageUrl
                                                                    options:NSDataReadingMappedIfSafe
                                                                      error:&stageDetailsError];
                    
                    if (stageDetailsError == nil)
                    {
                        RXMLElement *xml = [RXMLElement elementFromXMLData:stageResultData];
                        NSArray *stageDetailResults = [xml children:@"Competitor"];
                        for (RXMLElement *e in stageDetailResults)
                        {
                            NSInteger carNumber = [[e child:@"Number"] textAsInt];
                            NSString *stageTime = [[e child:@"StageTime"] text];
                            
                            [self setCompetitorStageDetailResultWithCarNumber:carNumber
                                                                      stageId:stageDetail.stageId
                                                                    stageName:stageDetail.name
                                                                  stageLength:stageDetail.stageLength
                                                                    stageTime:stageTime];
                            
                        }
                    }
                }
            }
            
            // We will also grab the retirements list...
            
            NSError* dnfError = nil;
            NSData *dnfData = [NSData dataWithContentsOfURL:urlRetirements
                                                    options:NSDataReadingMappedIfSafe
                                                      error:&dnfError];
            if (dnfError == nil)
            {
                
                RXMLElement *xml = [RXMLElement elementFromXMLData:dnfData];
                
                NSArray* results = [xml children:@"competitor"];
                
                for (RXMLElement *e in results) {
                    
                    NSInteger carNumber = [[e child:@"number"] textAsInt];
                    NSString *stage= [[e child:@"stage"] text];
                    NSString *comment = [[e child:@"reason"] text];
                    
                    [self setDNFReultsWithCarNumber:carNumber  Stage:stage Comment:comment];
                    
                    
                };
                
                //[[NSNotificationCenter defaultCenter] postNotificationName:@"DataLoadedFromNetwork" object:nil userInfo:nil];
            }
            else
            {
                //NSLog(@"Error fetching Network Data. Code: %i  Message: %@", callError.code, callError.description);
            }

            // We will also get any penalty information for the competitors
            
            NSError *penaltyError = nil;
            NSData *penaltyData = [NSData dataWithContentsOfURL:urlPenalties
                                                        options:NSDataReadingMappedIfSafe
                                                          error:&penaltyError];
            if (penaltyError == nil)
            {
                RXMLElement *xml = [RXMLElement elementFromXMLData:penaltyData];
                NSArray *penalties = [xml children:@"competitor"];
                
                // This is in just in case JGM does not fix the file and remove the empty car number in sequence...
                // It will store the last car number in the loop and do a check if the number from the file is 0
                // if it is it will set carNumber to the last car used for a penalty... When carNumber changes it will
                // update lastCarNumber
                
                NSInteger lastCarNumber = 0;
                
                for (RXMLElement *e in penalties)
                {
                    NSInteger carNumber = [[e child:@"number"] textAsInt];
                    NSString *driverCodriver = [[e child:@"driverCoDriver"] text];
                    //NSString *groupClass = [[e child:@"groupClass"] text];
                    NSString *control = [[e child:@"control"] text];
                    NSString *remark = [[e child:@"remark"] text];
                    NSString *penalty = [[e child:@"penalty"] text];
                    
                    if (carNumber == 0)
                    {
                        carNumber = lastCarNumber;
                    } else {
                        lastCarNumber = carNumber;
                    }
                    
                    [self setCompetitorPenaltyWithCarNumber:carNumber
                                             driverCodriver:driverCodriver
                                                    control:control
                                                     remark:remark
                                                    penalty:penalty];
                    
                }
            }
            // Here!!!
            
            // After all said and done...
            // If we have a competitors and a starting order (seeded draw) and results then we can sort our lists as required...
            
            if (self.hasStartingOrder && !self.hasResults)
            {
                // Sort by starting order when we do not have results
                NSSortDescriptor *withdrawnDescriptor = [[NSSortDescriptor alloc] initWithKey:@"withdrawn" ascending:YES];
                NSSortDescriptor *dnfDescriptior = [[NSSortDescriptor alloc] initWithKey:@"dnf" ascending:YES];
                NSSortDescriptor *startingOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startorder" ascending:TRUE];
                
                NSArray *competitorSortDescriptors = @[withdrawnDescriptor, dnfDescriptior, startingOrderDescriptor];
                
                [_competitors sortUsingDescriptors:competitorSortDescriptors];
            }
            else if (self.hasResults)
            {
                // We need to handle the possibility that we are missing some results... we will loop over the competitors
                // and if the overall position is empty then we will set it to 999 to be sorted to the end.
                
                [_competitors enumerateObjectsUsingBlock:^(tprCompetitor *competitor, NSUInteger idx, BOOL *stop) {
                    if (competitor.overallPosition == 0)
                    {
                        //competitor.overallPosition = 800 + competitor.carNumber;
                        competitor.overallPosition = 999;
                    }
                }];
                // Sort by the Results...
                //  First Sorter - isDNF (want DNF car lst)...
                //  Second Sorter - Position
                
                NSSortDescriptor *withdrawnDescriptor = [[NSSortDescriptor alloc] initWithKey:@"withdrawn" ascending:YES];
                NSSortDescriptor *dnfDescriptior = [[NSSortDescriptor alloc] initWithKey:@"dnf" ascending:YES];
                NSSortDescriptor *positionDescriptor = [[NSSortDescriptor alloc] initWithKey:@"overallPosition" ascending:YES];
                
                NSArray *competitorSortDescriptor = @[withdrawnDescriptor, dnfDescriptior, positionDescriptor];
                
                [_competitors sortUsingDescriptors:competitorSortDescriptor];
                
            }
            // Replce with the notification...
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DataLoadedFromNetwork" object:nil userInfo:nil];
        }
        else
        {
            //NSLog(@"Error fetching Network Data. Code: %i  Message: %@", callError.code, callError.description);
            //NSNotification return on error!!! we only reall care about the competitors list...
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DataLoadedFromNetworkError" object:nil userInfo:nil];
        }
        
        

        
    });

}



-(void)setOverallResultsWithCarNumber:(NSInteger)carNumber Position:(NSInteger)postion ClassPosition:(NSInteger)classPosition TotalTime:(NSString*)totalTime DifferenceToLeader:(NSString*)diffLeader DifferenceToPreviousCompetitor:(NSString*)diffPrev
{
    
    [_competitors enumerateObjectsUsingBlock:^(tprCompetitor *competitor, NSUInteger idx, BOOL *stop) {
        
        if (competitor.carNumber == carNumber) {

            competitor.overallPosition = postion;
            competitor.classPosition = classPosition;
            competitor.totalTime = totalTime;
            competitor.diffLeader = diffLeader;
            competitor.diffPrevious = diffPrev;
            
            //stop = TRUE;
        }
        
    }];
}

-(void)setDNFReultsWithCarNumber:(NSInteger)carNumber  Stage:(NSString*)stage Comment:(NSString*)comment
{
    [_competitors enumerateObjectsUsingBlock:^(tprCompetitor *competitor, NSUInteger idx, BOOL *stop) {
        
        if (competitor.carNumber == carNumber)
        {
            competitor.dnf = TRUE;
            competitor.dnfStage = stage;
            competitor.dnfComment = comment;
            
            //stop = TRUE;
        }
    }];
}

-(void)setCompetitorPenaltyWithCarNumber:(NSInteger)carNumber driverCodriver:(NSString *)driverCodriver control:(NSString *)control remark:(NSString *)remark penalty:(NSString *)penalty
{
    [_competitors enumerateObjectsUsingBlock:^(tprCompetitor *competitor, NSUInteger idx, BOOL *stop) {
        
        if (competitor.carNumber == carNumber)
        {
            [competitor addPenalty:penalty control:control remark:remark driverCodriver:driverCodriver];
        }
    }];
}

-(void)setCompetitorStageDetailResultWithCarNumber:(NSInteger)carNumber stageId:(NSString *)stageId stageName:(NSString *)stageName stageLength:(NSString *)stageLength stageTime:(NSString *)stageTime
{
    [_competitors enumerateObjectsUsingBlock:^(tprCompetitor *competitor, NSUInteger idx, BOOL *stop) {
        if (competitor.carNumber == carNumber) {
            [competitor addStageResultForStage:stageId
                                     stageName:stageName
                                   stageLength:stageLength
                                     stageTime:stageTime];
        }
    }];

}

-(void)setStageDetailsWithID:(NSString *)stageId name:(NSString *)name length:(NSString *)length resultFile:(NSString *)resultFile completed:(NSString *)completed
{
    tprStages *stageDetail = [[tprStages alloc] init];
    stageDetail.stageId = stageId;
    stageDetail.name = name;
    stageDetail.stageLength = length;
    stageDetail.resultFilename = resultFile;
    [stageDetail setCompletedStatus:completed];
    
    
    if (!self.stages)
    {
        self.stages = [[NSMutableArray alloc] init];
    }
    
    [self.stages addObject:stageDetail];
    
}

-(void)saveCompetitorsToStorage {
    
    // Store the array to the archive file
    NSLog(@"Saving Archive Data");
    NSArray *tempArray = [NSArray arrayWithArray:self.competitors];
    
    if (![NSKeyedArchiver archiveRootObject:tempArray toFile:[tprCompetitors getStorageLocation]])
    {
        NSLog(@"SaveFailed!"); 
    };
   
}

-(NSMutableArray *)getAll2WDCompetitors
{
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"(class = %@) OR (class = %@) OR (class =%@)", @"Production 2WD", @"Open 2WD", @"Group 5"];

    NSMutableArray *filteredArray = [[NSMutableArray alloc] initWithArray:_competitors];

    [filteredArray filterUsingPredicate:filterPredicate];
    
    return filteredArray;

}

-(NSMutableArray *)getAll4WDCompetitors
{
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"(class = %@) OR (class = %@)", @"Production 4WD", @"Open 4WD"];
    
    NSMutableArray *filteredArray = [[NSMutableArray alloc] initWithArray:_competitors];
    
    [filteredArray filterUsingPredicate:filterPredicate];
    
    return filteredArray;
    
}

@end
