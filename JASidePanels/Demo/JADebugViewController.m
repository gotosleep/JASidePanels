//
//  JADebugViewController.m
//  JASidePanels
//
//  Created by Jesse Andersen on 10/23/12.
//
//

#import "JADebugViewController.h"
#import "Macro.h"

@interface JADebugViewController ()

@end

@implementation JADebugViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    JAPrintBaseLog;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    JAPrintBaseLog;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    JAPrintBaseLog;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    JAPrintBaseLog;
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    [super willMoveToParentViewController:parent];
    JAPrintBaseLog;
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    [super didMoveToParentViewController:parent];
    JAPrintBaseLog;
}

@end
