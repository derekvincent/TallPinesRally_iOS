//
//  tprFeedLoader.h
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-11-03.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FeedLoaderCompleteBlock) (NSArray* results, NSError* error);

@interface tprFeedLoader : NSObject

-(void)fetchFeedXML:(FeedLoaderCompleteBlock)c;

@end
