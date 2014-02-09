//
//  tprAppInfoViewController.m
//  TallPinesRally
//
//  Created by Derek Vincent on 11/15/2013.
//  Copyright (c) 2013 Derek Vincent. All rights reserved.
//

#import "tprAppInfoViewController.h"
#import "FollowMeButton.h"

@interface tprAppInfoViewController ()

@property (nonatomic, strong) IBOutlet UIScrollView *scroller;
@property (nonatomic, strong) IBOutlet UIButton *facebookButton; 

@end

@implementation tprAppInfoViewController

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
	// Do any additional setup after loading the view.
    
    FollowMeButton *tallPinesTwitter = [[FollowMeButton alloc] initWithTwitterAccount:@"tallpinesrally" atOrigin:CGPointMake(28, 68)  isSmallButton:NO];
    [self.scroller addSubview:tallPinesTwitter];

    
    FollowMeButton *crcRallyTwitter = [[FollowMeButton alloc] initWithTwitterAccount:@"crcrally" atOrigin:CGPointMake(28, 116)  isSmallButton:NO];
    [self.scroller addSubview:crcRallyTwitter];
    
    FollowMeButton *mlrcTwitter = [[FollowMeButton alloc] initWithTwitterAccount:@"officialMLRC" atOrigin:CGPointMake(28, 164)  isSmallButton:NO];
    [self.scroller addSubview:mlrcTwitter];
    
    [_facebookButton addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)buttonTapped
{
    NSString *myUrls = @"fb://profile/167958129898982|http://www.facebook.com/TallPinesRally";
    NSArray *urls = [myUrls componentsSeparatedByString:@"|"];
    for (NSString *url in urls){
        NSURL *nsurl = [NSURL URLWithString:url];
        if ([[UIApplication sharedApplication] canOpenURL:nsurl]){
            [[UIApplication sharedApplication] openURL:nsurl];
            break;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
