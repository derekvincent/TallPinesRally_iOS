//
//  tprEntryDetailViewController.m
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-11-03.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import "tprEntryDetailViewController.h"
#import "tprCompetitor.h"

@interface tprEntryDetailViewController ()

@end

@implementation tprEntryDetailViewController

@synthesize teamLabel = _teamLabel;
@synthesize driverLabel = _driverLabel; 
@synthesize codriverLabel = _codriverLabel;
@synthesize carLabel = _carLabel;
@synthesize classLabel = _classLabel;
@synthesize carNumberLabel = _carNumberLabel;
@synthesize startOrderLabel = _startOrderLabel;
@synthesize teamImageView = _teamImageView;
@synthesize teamDecriptionView = _teamDecriptionView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    //{
    //    self.edgesForExtendedLayout = UIRectEdgeAll;
    //}
    //CGSize navBarSize = self.navigationController.navigationBar.bounds.size;
    //self.view.frame = CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height);
    //self.view.backgroundColor = [UIColor blueColor];
    
    tprCompetitor* competitor = (tprCompetitor*)self.detailItem;
    self.teamLabel.text = competitor.name;
    self.driverLabel.text = competitor.driver;
    self.codriverLabel.text = competitor.codriver;
    self.carLabel.text = competitor.car; 
    self.classLabel.text = competitor.class;
    self.carNumberLabel.text = [NSString stringWithFormat:@"%d", competitor.carNumber];
    self.startOrderLabel.text = competitor.getStartOrderWithOrdinalSuffix;
    self.teamDecriptionView.text = competitor.bio;
    
    if (competitor.isDNF) {
        // Hide Results information!
        [self.resultsView setHidden:TRUE];
        //Show DNF information!
        [self.dnfView setHidden:FALSE];
        
        [self.dnfView setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:99.0f/255.0f blue:71.0f/255.0f alpha:0.1]];
        self.dnfStageLabel.text = [NSString stringWithFormat:@"DNF - %@", competitor.dnfStage];
        self.dnfReasonLabel.text = competitor.dnfComment;

    } else {
        //Hide the DNF Page
        [self.dnfView setHidden:TRUE];
        // Show the results panel
        [self.resultsView setHidden:FALSE]; 
        if (competitor.overallPosition > 0 && competitor.overallPosition < 999)
        {
            self.poistionLabel.text = competitor.getOverallPoistionWithOrdinalSuffix;
            self.classPoistionLabel.text = competitor.getClassPoistionWithOrdinalSuffix;
            self.stageTimeLabel.text = [NSString stringWithFormat:@"Total stage time is %@", competitor.totalTime];
            if (competitor.overallPosition == 1) {
                self.diffToPreviousLabel.text = @"";
                self.diffToLeaderLabel.text = @"";
            } else {
                self.diffToLeaderLabel.text = [NSString stringWithFormat:@"%@ behind the overall leader", competitor.getDiffToLeaderFormated];
                if (competitor.overallPosition > 2)
                {
                    self.diffToPreviousLabel.text = [NSString stringWithFormat:@"%@ behind the %@ place competitor", competitor.getDiffToPreviousFormated, competitor.getPreviousPositionWithOrdinalSuffix];
                    [self.diffToPreviousLabel sizeToFit];
                } else {
                    self.diffToPreviousLabel.text = @"";
                }
            }
        } else {
            // If the position number are not between 1 and 998 then we have no results... hide the results panel!
            [self.resultsView setHidden:TRUE];
            // We happen to get a withdraw then we show it
            if (competitor.isWithdrawn) {
                [self.dnfView setHidden:FALSE];
                [self.dnfView setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:99.0f/255.0f blue:71.0f/255.0f alpha:0.1]];
                self.dnfStageLabel.text = @"WITHDRAWN";
                self.dnfReasonLabel.text = @""; 
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
