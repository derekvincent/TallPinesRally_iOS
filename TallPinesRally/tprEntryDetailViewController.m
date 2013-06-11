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
    
    
    
    tprCompetitor* competitor = (tprCompetitor*)self.detailItem;
    self.teamLabel.text = competitor.name;
    self.driverLabel.text = competitor.driver;
    self.codriverLabel.text = competitor.codriver;
    self.carLabel.text = competitor.car; 
    self.classLabel.text = competitor.class;
    self.carNumberLabel.text = [NSString stringWithFormat:@"%d", competitor.carNumber];
    self.startOrderLabel.text = [NSString stringWithFormat:@"%d", competitor.startorder];
    self.teamImageView.image = competitor.teamImage;
    self.teamDecriptionView.text = competitor.comment;
    
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
