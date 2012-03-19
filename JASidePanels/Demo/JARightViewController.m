//
//  JARightViewController.m
//  JASidePanels
//
//  Created by Jesse Andersen on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JARightViewController.h"

@interface JARightViewController ()

@end

@implementation JARightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor redColor];
	
	UILabel *label  = [[UILabel alloc] init];
	label.text = @"Right Panel";
	[label sizeToFit];
	CGRect frame = label.frame;
	frame.origin.x = self.view.bounds.size.width - 100.0f;
	label.frame = frame;
	label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
	[self.view addSubview:label];
}

@end
