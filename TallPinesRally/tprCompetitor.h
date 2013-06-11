//
//  tprCompetitor.h
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-10-30.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

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
@property (strong, nonatomic) UIImage* teamImage;


@end
