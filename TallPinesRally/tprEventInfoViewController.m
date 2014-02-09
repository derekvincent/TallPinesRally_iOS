//
//  tprFirstViewController.m
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-10-25.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import "tprEventInfoViewController.h"

@interface tprEventInfoViewController ()

@end

@implementation tprEventInfoViewController

@synthesize eventWebView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //[self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    NSString *path;
    NSBundle *thisBundle = [NSBundle mainBundle];
    path = [thisBundle pathForResource:@"EventInfo" ofType:@"html"];
    
    NSURL *eventInfoURL = [NSURL fileURLWithPath:path];
    [eventWebView loadRequest:[NSURLRequest requestWithURL:eventInfoURL]];
   
    
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

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.navigationController pushViewController:eventWebView animated:YES];
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

                                                        - (void)viewDidUnload {
                                                            [self setEventWebView:nil];
                                                            [super viewDidUnload];
                                                        }
@end
