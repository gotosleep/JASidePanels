//
//  JAViewController.h
//  JASidePanels
//
//  Created by Jesse Andersen on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JASidePanelViewController : UIViewController

@property (nonatomic, strong) UIViewController *leftPanel;
@property (nonatomic, strong) UIViewController *centerPanel;
@property (nonatomic, strong) UIViewController *rightPanel;

@property (nonatomic) CGFloat leftGapPercentage;
@property (nonatomic) CGFloat rightGapPercentage;
@property (nonatomic) CGFloat minimumMovePercentage;
@property (nonatomic) CGFloat maximumAnimationDuration;
@property (nonatomic) CGFloat bounceDuration;

+ (UIImage *)defaultImage;

- (void)showLeftPanel:(BOOL)animated;
- (void)showRightPanel:(BOOL)animated;
- (void)showCenterPanel:(BOOL)animated;

@end
