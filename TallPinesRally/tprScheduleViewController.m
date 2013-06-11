//
//  tprSecondViewController.m
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-10-25.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import "tprScheduleViewController.h"

@interface tprScheduleViewController ()

@end

@implementation tprScheduleViewController

@synthesize scheduleWebView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *path;
    NSBundle *thisBundle = [NSBundle mainBundle];
    path = [thisBundle pathForResource:@"schedule" ofType:@"html"];
    
    NSURL *eventInfoURL = [NSURL fileURLWithPath:path];
    [scheduleWebView loadRequest:[NSURLRequest requestWithURL:eventInfoURL]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
