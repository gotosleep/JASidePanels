/*
 Copyright (c) 2012 Jesse Andersen. All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 If you happen to meet one of the copyright holders in a bar you are obligated
 to buy them one pint of beer.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */


#import "JAAppDelegate.h"

#import "JASidePanelController.h"
#import "JACenterViewController.h"
#import "JALeftViewController.h"
#import "JARightViewController.h"

@implementation JAAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    JASidePanelController *sidePanelController = [[JASidePanelController alloc] init];
    sidePanelController.delegate =  self;
	self.viewController = sidePanelController;
    
    self.viewController.shouldDelegateAutorotateToVisiblePanel = NO;
    
	self.viewController.leftPanel = [[JALeftViewController alloc] init];
	self.viewController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[JACenterViewController alloc] init]];
	self.viewController.rightPanel = [[JARightViewController alloc] init];
	
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - JASidePanelControllerDelegate

#pragma mark Customisation

- (CGFloat)borderRadiusForPanel:(UIView *)panel {
    return 0.0f;
}

- (UIImage *)imageForLeftButtonForCenterPanel {
    return [UIImage imageNamed:@"menu-icon"];
}

#pragma mark Event Notifications

- (void)panelController:(JASidePanelController *)panelController willShowLeftPanelAnimated:(BOOL)animated {
    NSLog(@"willShowLeftPanelAnimated");
}

- (void)panelController:(JASidePanelController *)panelController willShowRightPanelAnimated:(BOOL)animated {
    NSLog(@"willShowRightPanelAnimated");
}

- (void)panelController:(JASidePanelController *)panelController willShowCenterPanelAnimated:(BOOL)animated {
    NSLog(@"willShowCenterPanelAnimated");
}



@end
