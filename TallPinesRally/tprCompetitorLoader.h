//
//  tprCompetitorLoader.h
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-10-30.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompetitorLoaderCompleteBlock) (NSArray* results, NSError* error);

@interface tprCompetitorLoader : NSObject

- (void)fetchCompetitorXML:(CompetitorLoaderCompleteBlock)c;
@end
