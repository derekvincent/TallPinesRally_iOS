//
//  tprEntryViewController.m
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-10-25.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import "tprEntryViewController.h"
#import "tprCompetitor.h"
#import "tprCompetitorLoader.h"
#import "tprCompetitorTableCell.h"
#import "tprEntryDetailViewController.h"

@interface tprEntryViewController (){
    NSArray *_objects;
    UIRefreshControl* refreshControl;
}
@end

@implementation tprEntryViewController


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
    
    [activityIndicator startAnimating];
    [self refreshCompetitor];
}



-(void) refreshInvoked:(id)sender forState: (UIControlState)state {
    [self refreshCompetitor];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //[activityIndicator startAnimating];
}

-(void)refreshCompetitor
{
    tprCompetitorLoader* competitor = [[tprCompetitorLoader alloc] init];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //[activityIndicator startAnimating];
    [competitor fetchCompetitorXML:^(NSArray *results, NSError *error) {
                    //completed fetching the Competitor List
 
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        
                        if (results != nil) {
                            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startorder" ascending:YES];
                            NSArray *sortedResults = [results sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
                            
                            //_objects = results;
                            _objects = sortedResults;
                            
                            
                            [self.tableView reloadData];                            
                        }
                        else {
                            if (error != nil)
                            {
                                [self errorMessageWithNetwork];
                            }
                            
                        }

                        
                        
                        // Stop refresh control
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
    return 82;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    tprCompetitorTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompetitorCell" forIndexPath:indexPath];
    
    tprCompetitor *object = _objects[indexPath.row];
    cell.driverNameLabel.text = object.driver;
    cell.codriverNameLabel.text = object.codriver;
    cell.carLabel.text = object.car;
    cell.startOrderLabel.text = [NSString stringWithFormat:@"%d", object.startorder];
    cell.teamImageView.image = object.teamImage; 

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        tprCompetitor *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
        
    }
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
