//
//  tprSpectatorDetailViewController.h
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-10-30.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface tprSpectatorDetailViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) id detailLocation;
@property (strong, nonatomic) IBOutlet UIWebView *locationWebView;


@end
