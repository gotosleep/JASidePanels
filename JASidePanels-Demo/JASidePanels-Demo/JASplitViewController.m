//
//  JASplitViewController.m
//  JASidePanels-Demo
//
//  Created by Andrey Yastrebov on 28.08.13.
//  Copyright (c) 2013 AgileFusion. All rights reserved.
//

#import "JASplitViewController.h"

@interface JASplitViewController ()

@end

@implementation JASplitViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        _masterViewController = self.viewControllers[0];
        _detailViewController = self.viewControllers[1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view bringSubviewToFront:self.detailViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end
