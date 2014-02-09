//
//  tprCompetitorLoader.m
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-10-30.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import "tprCompetitorLoader.h"
#import "RXMLElement.h"
#import "tprCompetitor.h"
#import "Utillities.h"
#import "tprEntryViewController.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@implementation tprCompetitorLoader

- (void)fetchCompetitorXML:(CompetitorLoaderCompleteBlock)c
{
    //NSURL *url = [NSURL URLWithString:@"http://www.directdynamics.ca/teams.xml"];
    NSURL *url = [NSURL URLWithString:@"http://tallpinesrally.com/compete/entrylist?xml=1"];

        dispatch_async(kBgQueue, ^{
            
            //work in the background
            
            NSError* error = nil;
            
            NSData *data = [NSData dataWithContentsOfURL:url
                                                 options:NSDataReadingMappedIfSafe
                                                   error:&error];
            if (error == nil)
            {
            
                RXMLElement *xml = [RXMLElement elementFromXMLData:data];
                
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
                    
                    //Preload the Team image if avaliable
                    if (team.photo.length > 0) {
                        NSString *teamPhoto = @"http://directdynamics.ca/images/";
                        teamPhoto = [teamPhoto stringByAppendingString:team.photo];
                        
                        NSLog(@"Team Photo ID: %@", teamPhoto);
                        
                        Utillities *utils = [[Utillities alloc] init];
                        UIImage *image = [utils getCachedImage:teamPhoto imageName:team.photo];
                        
                        //NSURL *imageURL = [NSURL URLWithString:teamPhoto];
                        //NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                        //UIImage *image = [UIImage imageWithData:imageData];
                        
                        team.teamImage = image;
                        
                    }
                    
                    NSLog(@"Competitor %i Driver: %@ coDriver %@", team.id, team.driver, team.codriver);
                    [result addObject: team];
                }
                
                c (result, error);
            }
            else
            {
                NSLog(@"Error fetching Network Data. Code: %i  Message: %@", error.code, error.description);
                
                // Return an empty array with the error object
                c(nil, error);
            }
        });
    
}


@end
