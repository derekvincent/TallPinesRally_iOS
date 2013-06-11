//
//  tprFeed.h
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-11-03.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tprFeed : NSObject

@property (strong, nonatomic) NSString* twMessage;
@property (strong, nonatomic) NSString* twDate;
@property (strong, nonatomic) NSString* twid;
@property (assign, nonatomic) CGFloat   cellHeight;
@end
