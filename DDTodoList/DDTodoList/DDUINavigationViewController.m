//
//  DDUINavigationViewController.m
//  DDTodoList
//
//  Created by Daniel Djurfelter on 07/03/16.
//  Copyright © 2016 Daniel Djurfelter. All rights reserved.
//

#import "DDUINavigationViewController.h"

@interface DDUINavigationViewController ()

@end

@implementation DDUINavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    const CGFloat *componentColors = CGColorGetComponents([self.navigationBar barTintColor].CGColor);
    CGFloat colorBrightness = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000;
    if (colorBrightness < 0.5) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

@end
