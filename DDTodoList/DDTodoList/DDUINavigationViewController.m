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
    return UIStatusBarStyleLightContent;
}

@end
