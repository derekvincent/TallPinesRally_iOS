//
//  tprSpectatorDetailViewController.m
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-10-30.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import "tprLocationsViewController.h"
#import "tprSpectatorDetailViewController.h"

@interface tprSpectatorDetailViewController ()

@end

@implementation tprSpectatorDetailViewController

@synthesize locationWebView = _locationWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    //NSLog(@"Current Index: %@", self.detailLocation);
    NSString *path;
    NSBundle *thisBundle = [NSBundle mainBundle];
    path = [thisBundle pathForResource: self.detailLocation ofType:@"html"];
    
    //NSLog(@"Spectator Load path: %@", path);
    NSURL *eventInfoURL = [NSURL fileURLWithPath:path];
    [_locationWebView loadRequest:[NSURLRequest requestWithURL:eventInfoURL]];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated]; 
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ( navigationType == UIWebViewNavigationTypeLinkClicked )
    {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
