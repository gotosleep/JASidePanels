//
//  JADebugViewController.m
//  JASidePanels
//
//  Created by Jesse Andersen on 10/23/12.
//
//

#import "JADebugViewController.h"

@interface JADebugViewController ()

@end

@implementation JADebugViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@ viewWillAppear", self);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@ viewDidAppear", self);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%@ viewWillDisappear", self);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"%@ viewDidDisappear", self);
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    [super willMoveToParentViewController:parent];
    NSLog(@"%@ willMoveToParentViewController %@", self, parent);
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    [super didMoveToParentViewController:parent];
    NSLog(@"%@ didMoveToParentViewController %@", self, parent);
}

- (void)willBecomeActiveAsPanelAnimated:(BOOL)animated withBounce:(BOOL)withBounce
{
    NSLog(@"%@ willBecomeActiveAsPanelAnimated:withBounce:", self);
}

- (void)didBecomeActiveAsPanelAnimated:(BOOL)animated withBounce:(BOOL)withBounce
{
    NSLog(@"%@ didBecomeActiveAsPanelAnimated:withBounce:", self);
}

- (void)willResignActiveAsPanelAnimated:(BOOL)animated withBounce:(BOOL)withBounce
{
    NSLog(@"%@ willResignActiveAsPanelAnimated:withBounce:", self);
}

- (void)didResignActiveAsPanelAnimated:(BOOL)animated withBounce:(BOOL)withBounce
{
    NSLog(@"%@ didResignActiveAsPanelAnimated:withBounce:", self);
}

@end
