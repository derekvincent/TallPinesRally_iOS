//
//  tprCompetitors.h
//  TallPinesRally
//
//  Created by Derek Vincent on 10/31/2013.
//  Copyright (c) 2013 Derek Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tprCompetitors : NSObject

@property (nonatomic, strong) NSMutableArray *competitors;
@property (nonatomic, assign, getter=hasStartingOrder) BOOL startingOrder;
@property (nonatomic, assign, getter = hasResults) BOOL results; 


+(NSString *)getStorageLocation;
-(void)loadCompetitorsFromStorage;
-(void)saveCompetitorsToStorage;
-(void)loadCompetitorsFromWeb;





@end
