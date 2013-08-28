//
//  JASplitViewController.h
//  JASidePanels-Demo
//
//  Created by Andrey Yastrebov on 28.08.13.
//  Copyright (c) 2013 AgileFusion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JASplitViewController : UISplitViewController
@property(nonatomic, weak) UIViewController *masterViewController;
@property(nonatomic, weak) UIViewController *detailViewController;
@end
