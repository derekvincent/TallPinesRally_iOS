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
#import "tprCompetitorNewTableCell.h"
#import "tprEntryDetailViewController.h"
#import "tprCompetitors.h"

@interface tprEntryViewController (){
    NSArray *_objects;
    NSInteger competitorFilter;
    tprCompetitors *competitors;
    UIRefreshControl* refreshControl;
    
    
    //?
    //UISegmentedControl *filterControl;
}
@end

@implementation tprEntryViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter]
        addObserver:self
        selector:@selector(xmlDataLoaded)
        name:@"DataLoadedFromNetwork"
        object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(dataLoaderError)
     name:@"DataLoadedFromNetworkError"
     object:nil];
    
    
    // Testing custom area above cells and below pull to refresh
    
    CGFloat headerHeight = 45.0f;
    CGFloat headerWidth = 320.0f;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerWidth, headerHeight)];
    UIView *headerContentView = [[UIView alloc]initWithFrame:headerView.bounds];

    
    headerContentView.autoresizingMask =UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Setup the Content of the Header View
    UISegmentedControl *headerFilter = [[UISegmentedControl alloc] initWithItems:@[@"All", @"2WD", @"4WD"]];
    
    NSDictionary *headerFilterNormalAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                            [UIFont fontWithName:@"ITCAvantGardeStd-Md" size:14], UITextAttributeFont,
                                            nil];
    
    NSDictionary *headerFilterHighlightedAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIFont fontWithName:@"ITCAvantGardeStd-Demi" size:16], UITextAttributeFont,
                                                       [UIColor lightGrayColor], UITextAttributeTextColor,
                                                       nil];
    
    [headerFilter setTitleTextAttributes:headerFilterNormalAttributes forState:UIControlStateNormal];
    [headerFilter setTitleTextAttributes:headerFilterHighlightedAttributes forState:UIControlStateSelected];
    
    CGFloat headerFilterOffsetX = 20.0f;
    CGFloat headerFilterOffsetY = 5.0f;
    [headerFilter setFrame:CGRectMake(headerFilterOffsetX,
                                      headerFilterOffsetY,
                                      headerWidth - 2*headerFilterOffsetX,
                                      headerHeight - 2*headerFilterOffsetY)];
    
    [headerFilter setTintColor: [UIColor blackColor]];
    [headerFilter addTarget:self action:@selector(headerFilterAction:) forControlEvents:UIControlEventValueChanged];
    // Auto set segment to all.
    [headerFilter setSelectedSegmentIndex:0];
    // Add the content to the
    [headerContentView addSubview:headerFilter];
    [headerView addSubview:headerContentView];
    
    
    self.tableView.tableHeaderView = headerView;

    // End of Testing...
    competitors = [[tprCompetitors alloc] init];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.color = [UIColor blackColor];
    [activityIndicator setHidesWhenStopped:TRUE];
    [activityIndicator setCenter:self.view.center];
    [self.view addSubview: activityIndicator];
    
    refreshControl = [[UIRefreshControl alloc] init];
    
    [refreshControl addTarget:self
                       action:@selector(refreshInvoked:forState:)
             forControlEvents:UIControlEventValueChanged];

    
    [self.tableView addSubview:refreshControl];
    
    // Set the navigation Bar Tiitle...
    //[self.navigationItem setTitle:@"Competitors"];
    // No Idea!
    /*
    tprCompetitors *peeps = [[tprCompetitors alloc]init];
    
    tprCompetitor *comp1 = [[tprCompetitor alloc]init];
    comp1.carNumber = 1;
    comp1.driver = @"Derek Vincent";
    NSArray *peepsArrray = [NSArray arrayWithObject:comp1];
    peeps.competitors = peepsArrray;
    [peeps saveCompetitorsToStorage];
    */
    competitors = [[tprCompetitors alloc]init];
    [competitors loadCompetitorsFromStorage];
    
    //[activityIndicator startAnimating];
    [self refreshCompetitor];
}

-(void) headerFilterAction:(UISegmentedControl *)segment
{
    //NSLog(@"Segment %li selected", (long)segment.selectedSegmentIndex);
    competitorFilter = segment.selectedSegmentIndex;
    [self filteredCompetitors];
}

-(void) refreshInvoked:(id)sender forState: (UIControlState)state {
    [self refreshCompetitor];
    //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //[activityIndicator startAnimating];
}

-(void)refreshCompetitor
{
    

    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [activityIndicator startAnimating];
    
    [competitors loadCompetitorsFromWeb];

}

-(void)xmlDataLoaded
{
    dispatch_async(dispatch_get_main_queue(), ^{
    
        [self filteredCompetitors];
        
        [refreshControl endRefreshing];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [activityIndicator stopAnimating];
    });
    
}

-(void)dataLoaderError
{
        dispatch_async(dispatch_get_main_queue(), ^{
    [self errorMessageWithNetwork];
    [refreshControl endRefreshing];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [activityIndicator stopAnimating];
        });
    
}

-(void)filteredCompetitors
{
    if (competitorFilter == 1) {
        _objects = [competitors getAll2WDCompetitors];
    }
    else if (competitorFilter == 2) {
        _objects = [competitors getAll4WDCompetitors];
    } else {
        _objects = competitors.competitors;
    }
    
    [self.tableView reloadData];
    
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

    tprCompetitorNewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompetitorNewCell" forIndexPath:indexPath];
    
    tprCompetitor *object = _objects[indexPath.row];
    
    // Set the base colours back...
    cell.backgroundColor = [UIColor whiteColor];
    cell.position.textColor = [UIColor blackColor];
    cell.totalTime.textColor = [UIColor blackColor];
    cell.carNumberLabel.textColor = [UIColor whiteColor];
    cell.backgroundCircle.layer.cornerRadius = 23;
    cell.backgroundCircle.layer.masksToBounds = YES;
    
    //cell.driverNameLabel.text = object.driver;
    //cell.codriverNameLabel.text = object.codriver;
    //cell.carLabel.text = object.car;
    
    NSMutableAttributedString *driverNameAttributedString = [[NSMutableAttributedString alloc] initWithString:object.driver];
    NSMutableAttributedString *codriverNameAttributedString = [[NSMutableAttributedString alloc] initWithString:object.codriver];
    NSMutableAttributedString *carNameAttributedString = [[NSMutableAttributedString alloc] initWithString:object.car];
    if (object.isWithdrawn) {
        [driverNameAttributedString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInt:2] range:NSMakeRange(0, [driverNameAttributedString length])];
        [codriverNameAttributedString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInt:2] range:NSMakeRange(0, [codriverNameAttributedString length])];
        [carNameAttributedString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInt:2] range:NSMakeRange(0, [carNameAttributedString length])];
    }
    cell.driverNameLabel.attributedText = driverNameAttributedString;
    cell.codriverNameLabel.attributedText = codriverNameAttributedString;
    cell.carLabel.attributedText = carNameAttributedString;
    
    cell.classLabel.text = object.classShorter;
    cell.carNumberLabel.text = [NSString stringWithFormat:@"%ld", (long)object.carNumber];

    /* Refactored below... 
    if ( (!object.isDNF) || (!object.isWithdrawn) )
    {
        if (competitors.hasStartingOrder && !competitors.hasResults) {
            // Set the start order and blank the rest!
            if(object.isWithdrawn) {
                cell.position.text = @"WITHDRAWN";
                cell.position.textColor = [UIColor redColor];
            } else {
            cell.position.text = object.getStartOrderWithOrdinalSuffix;
            }
            cell.totalTime.text = @"";
            cell.diffToLeader.text = @"";
            cell.diffToPrevious.text = @"";
        } else if (competitors.hasResults) {
            cell.position.text = object.getOverallPoistionWithOrdinalSuffix;
            cell.totalTime.text = object.totalTime;
            if (indexPath.row > 0) {
                if (object.overallPosition == 999) {
                    cell.diffToLeader.text = @"";
                    cell.diffToPrevious.text = @"";
                } else {
                cell.diffToLeader.text = [NSString stringWithFormat:@" 1st +%@", object.getDiffToLeaderFormated];
                    if (object.overallPosition == 2) {
                        cell.diffToPrevious.text = @"";
                    } else {
                        cell.diffToPrevious.text = [NSString stringWithFormat:@"%@ +%@", object.getPreviousPositionWithOrdinalSuffix, object.getDiffToPreviousFormated];
                    }
                }
            } else {
                // If the leader then no diff's
                cell.diffToLeader.text = @"";
                cell.diffToPrevious.text = @"";
            }
        } else {
            // We have not starting order or results so blank all fields...
            cell.position.text = @"";
            cell.totalTime.text = @"";
            cell.diffToLeader.text = @"";
            cell.diffToPrevious.text = @""; 
        }
        
    } else if (object.isWithdrawn) {
       
        cell.position.text = @"WITHDRAWN";
        cell.position.textColor = [UIColor redColor];

    }
    else if (object.isDNF) {
        cell.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:99.0f/255.0f blue:71.0f/255.0f alpha:0.1];
        cell.position.textColor = [UIColor redColor];
        cell.totalTime.textColor = [UIColor redColor];
        cell.carNumberLabel.textColor = [UIColor redColor];
        
        cell.position.text = @"DNF";
        cell.totalTime.text = object.dnfStage;
        
        cell.diffToLeader.text = @"";
        cell.diffToPrevious.text = @"";
    }
*/
    if (object.isWithdrawn)
    {
        cell.position.text = @"WITHDRAWN";
        cell.position.textColor = [UIColor redColor];
        cell.totalTime.text = @"";
        cell.diffToLeader.text = @"";
        cell.diffToPrevious.text = @"";
        
    } else if (object.isDNF)
    {
        cell.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:99.0f/255.0f blue:71.0f/255.0f alpha:0.1];
        cell.position.textColor = [UIColor redColor];
        cell.totalTime.textColor = [UIColor redColor];
        //cell.carNumberLabel.textColor = [UIColor redColor];
        
        cell.position.text = @"DNF";
        cell.totalTime.text = object.dnfStage;
        
        cell.diffToLeader.text = @"";
        cell.diffToPrevious.text = @"";
    } else {
        
        if (competitors.hasStartingOrder && !competitors.hasResults) {
            // Set the start order and blank the rest!
            //if(object.isWithdrawn) {
             //   cell.position.text = @"WITHDRAWN";
             //   cell.position.textColor = [UIColor redColor];
            //} else {
                cell.position.text = object.getStartOrderWithOrdinalSuffix;
            //}
            cell.totalTime.text = @"";
            cell.diffToLeader.text = @"";
            cell.diffToPrevious.text = @"";
        } else if (competitors.hasResults) {
            cell.position.text = object.getOverallPoistionWithOrdinalSuffix;
            cell.totalTime.text = object.totalTime;
            if (indexPath.row > 0) {
                if (object.overallPosition == 999) {
                    cell.diffToLeader.text = @"";
                    cell.diffToPrevious.text = @"";
                } else {
                    cell.diffToLeader.text = [NSString stringWithFormat:@" 1st +%@", object.getDiffToLeaderFormated];
                    if (object.overallPosition == 2) {
                        cell.diffToPrevious.text = @"";
                    } else {
                        cell.diffToPrevious.text = [NSString stringWithFormat:@"%@ +%@", object.getPreviousPositionWithOrdinalSuffix, object.getDiffToPreviousFormated];
                    }
                }
            } else {
                // If the leader then no diff's
                cell.diffToLeader.text = @"";
                cell.diffToPrevious.text = @"";
            }
        } else {
            // We have not starting order or results so blank all fields...
            cell.position.text = @"";
            cell.totalTime.text = @"";
            cell.diffToLeader.text = @"";
            cell.diffToPrevious.text = @"";
        }
    }
     
//cell.startOrderLabel.text = [NSString stringWithFormat:@"%d", object.startorder];
    //cell.teamImageView.image = object.teamImage;

    return cell;
}


// Will be moved...

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        tprCompetitor *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
        
    }
}

-(void)errorMessageWithNetwork {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
                                                    message:@"You must be connected to the internet to use this application."
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
