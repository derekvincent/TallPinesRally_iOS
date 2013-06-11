//
//  Utillities.h
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-11-03.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utillities : NSObject
-(void) cacheImage: (NSString *) ImageURLString imageName: (NSString *) ImageName;
-(UIImage *) getCachedImage: (NSString *) ImageURLString imageName: (NSString *) ImageName;

@end
