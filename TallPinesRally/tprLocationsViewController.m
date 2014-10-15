//
//  tprLocationsViewController.m
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-10-25.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import "tprLocationsViewController.h"
#import "tprSpectatorDetailViewController.h"

@interface tprLocationsViewController ()

@end

@implementation tprLocationsViewController

@synthesize locationsArray = _locationsArray;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _locationsArray = [NSMutableArray array];
    [_locationsArray addObject:[NSMutableArray arrayWithObjects:@"Service Area & Rally HQ",@"Enjoy a behind the scenes view into the cars and service crews. As well as the cerimonial start and finsih of the event.", @"rallyhq", nil]];
    [_locationsArray addObject:[NSMutableArray arrayWithObjects:@"Iron Bridge Spectator Area",@"The classic and popular Iron Bridge area never fails to entertain!", @"ironbridge", nil]];
    [_locationsArray addObject:[NSMutableArray arrayWithObjects:@"Golton Super Special Spectator Area",@"Superb viewing of the cars in action at this Super Special night stage.",@"golton", nil]];

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_locationsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.font = [UIFont fontWithName:@"ITCAvantGardeStd-Md" size:cell.textLabel.font.pointSize];
    cell.textLabel.text = [[_locationsArray objectAtIndex:indexPath.row] objectAtIndex:0];
    cell.detailTextLabel.font = [UIFont fontWithName:@"ITCAvantGardeStd-Md" size:cell.detailTextLabel.font.pointSize];
    cell.detailTextLabel.text = [[_locationsArray objectAtIndex:indexPath.row] objectAtIndex:1];
    cell.detailTextLabel.numberOfLines = 0; 
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    //return cell.frame.size.height;
    return 100;

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *location = [[_locationsArray objectAtIndex:indexPath.row] objectAtIndex:2];
        
        NSLog(@"Index: %i and Navigation %@ ", indexPath.row, (NSString *)location);
        
        [[segue destinationViewController] setDetailLocation: (NSString *)location];
    }
}


@end
