
//
//  UITextView+RPRCustomFont.m
//  TallPinesRally
//
//  Created by Derek Vincent on 11/14/2013.
//  Copyright (c) 2013 Derek Vincent. All rights reserved.
//

#import "UITextView+RPRCustomFont.h"

@implementation UITextView (RPRCustomFont)

- (NSString *)fontName {
    return self.font.fontName;
}

- (void)setFontName:(NSString *)fontName {
    self.font = [UIFont fontWithName:fontName size:self.font.pointSize];
}

@end
