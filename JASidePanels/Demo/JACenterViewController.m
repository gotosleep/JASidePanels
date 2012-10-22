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

#import "JACenterViewController.h"

@interface JACenterViewController ()

@end

@implementation JACenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat red = (CGFloat)arc4random() / 0x100000000;
    CGFloat green = (CGFloat)arc4random() / 0x100000000;
    CGFloat blue = (CGFloat)arc4random() / 0x100000000;
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    
    UILabel *label  = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:20.0f];
    label.text = @"Center Panel";
    [label sizeToFit];
    label.center = CGPointMake(floorf(self.view.bounds.size.width/2.0f), floorf((self.view.bounds.size.height - self.navigationController.navigationBar.frame.size.height)/2.0f));
    label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:label];
}

- (void)viewWillAppear:(BOOL)animated {
	NSLog(@"%@ viewWillAppear", self);
}

- (void)viewDidAppear:(BOOL)animated {
	NSLog(@"%@ viewDidAppear", self);
}

- (void)viewWillDisappear:(BOOL)animated {
	NSLog(@"%@ viewWillDisappear", self);
}

- (void)viewDidDisappear:(BOOL)animated {
	NSLog(@"%@ viewDidDisappear", self);
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
	NSLog(@"%@ willMoveToParentViewController %@", self, parent);
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
	NSLog(@"%@ didMoveToParentViewController %@", self, parent);
}

@end
