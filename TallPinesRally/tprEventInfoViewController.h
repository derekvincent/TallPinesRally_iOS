//
//  tprFirstViewController.h
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-10-25.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tprEventInfoViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *eventWebView;
@property (weak, nonatomic) IBOutlet UIImageView *tpHeaderImage;

@end
