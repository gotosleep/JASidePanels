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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.masterViewController = self.viewControllers[0];
    self.detailViewController = self.viewControllers[1];
        
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
