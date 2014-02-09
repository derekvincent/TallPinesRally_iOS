//
//  tprFeedLoader.m
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-11-03.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import "tprFeedLoader.h"
#import "RXMLElement.h"
#import "tprFeed.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@implementation tprFeedLoader

-(void)fetchFeedXML:(FeedLoaderCompleteBlock)c
{
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/user_timeline.xml?id=tallpinesrally&since_id=141901385259155456"];
    
    dispatch_async(kBgQueue, ^{
        
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:url
                                             options:NSDataReadingMappedIfSafe
                                               error:&error];
        
        if( error == nil)
        {
            RXMLElement *xml = [RXMLElement elementFromXMLData: data];
            NSArray* feeds = [xml children:@"status"];
            
            NSMutableArray* result = [NSMutableArray arrayWithCapacity:feeds.count];
            
            for (RXMLElement *e in feeds)
            {
                tprFeed* feed = [[tprFeed alloc] init];
                
                feed.twid       = [[e child:@"id"] text];
                feed.twMessage  = [[e child:@"text"] text];
                feed.twDate     = [[e child:@"created_at"] text];
                
                NSLog(@"Message ID: %@  at  %@ Message: %@", feed.twid, feed.twDate, feed.twMessage);
                [result addObject:feed];
            }
            c (result, error);
        }
        else {
            
            NSLog(@"Error fetching Network Data. Code: %i  Message: %@", error.code, error.description);
            
            // Return an empty array with the error object
            c(nil, error);
        }

    });
}

@end
