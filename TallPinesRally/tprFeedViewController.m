//
//  tprFeedViewController.m
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-10-25.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import "tprFeedViewController.h"
#import "tprFeed.h"
#import "tprFeedLoader.h"
#import "tprFeedTableCell.h"

@interface tprFeedViewController () {
    NSArray *_objects;
    UIRefreshControl* refreshControl;
}

@end

@implementation tprFeedViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.color = [UIColor blackColor];
    [activityIndicator setCenter:self.view.center];
    [self.view addSubview: activityIndicator];

    
    refreshControl = [[UIRefreshControl alloc] init];
    
    [refreshControl addTarget:self
                       action:@selector(refreshInvoked:forState:)
             forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:refreshControl];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self refreshFeed];
    [activityIndicator startAnimating];
    
   
}
-(void) refreshInvoked:(id)sender forState: (UIControlState)state {
    [self refreshFeed];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //[activityIndicator startAnimating];
}
-(void)refreshFeed
{
    tprFeedLoader* feed = [[tprFeedLoader alloc] init];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //[activityIndicator startAnimating];
    
    [feed fetchFeedXML:^(NSArray *results, NSError *error) {
        //completed fetching the Feed from Twitter
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (results != nil)
            {
                _objects = results;
                [self.tableView reloadData];
            } else {
                if (error != nil) {
                    
                    [self errorMessageWithNetwork];
                }
            }

            
            
            
            // Stop refresh control
            //[self.refreshControl endRefreshing];
            [refreshControl endRefreshing];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [activityIndicator stopAnimating];
            
        });
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    tprFeed *object = [_objects objectAtIndex:indexPath.row];
    NSString *cellText = object.twMessage;
    
    CGSize size = [cellText sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(320, 999)lineBreakMode:NSLineBreakByWordWrapping];
    
    NSLog(@"Row Text Size with 14 font: %f", size.height);
    //return tableView.rowHeight + size.height;
    return size.height +10;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    tprFeedTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedCell" forIndexPath:indexPath];
    
    tprFeed *object = _objects[indexPath.row];
    cell.twTextView.text = object.twMessage;
    [cell.twTextView setContentInset:UIEdgeInsetsMake(-5, 0, 5, 0)];
    
    CGSize size = [object.twMessage sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(320, 999)lineBreakMode:NSLineBreakByWordWrapping];
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, size.width, size.height);
    
    NSLog(@"CellText Size with 14 font: %f", size.height);
    
    return cell;
}

-(void)errorMessageWithNetwork {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
                                                    message:@"You must be connected to the internet to use this app."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
