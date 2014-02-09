//
//  UILabel+TPRCustomFont.m
//  TallPinesRally
//
//  Created by Derek Vincent on 11/8/2013.
//  Copyright (c) 2013 Derek Vincent. All rights reserved.
//

#import "UILabel+TPRCustomFont.h"

@implementation UILabel (TPRCustomFont)

- (NSString *)fontName {
    return self.font.fontName;
}

- (void)setFontName:(NSString *)fontName {
    self.font = [UIFont fontWithName:fontName size:self.font.pointSize];
}

@end
