//
//  JAViewController.h
//  JASidePanels
//
//  Created by Jesse Andersen on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _JASidePanelStyle {
	JASidePanelSingleActive = 0,
	JASidePanelMultipleActive
} JASidePanelStyle;

typedef enum _JASidePanelState {
	JASidePanelCenterVisible = 1,
	JASidePanelLeftVisible,
	JASidePanelRightVisible
} JASidePanelState;

@interface JASidePanelController : UIViewController<UIGestureRecognizerDelegate>

// style
@property (nonatomic) JASidePanelStyle style;

// state
@property (nonatomic, readonly) JASidePanelState state;

// panel containers
@property (nonatomic, strong, readonly) UIView *leftPanelContainer;
@property (nonatomic, strong, readonly) UIView *rightPanelContainer;
@property (nonatomic, strong, readonly) UIView *centerPanelContainer;

// panels
@property (nonatomic, strong) UIViewController *leftPanel;
@property (nonatomic, strong) UIViewController *centerPanel;
@property (nonatomic, strong) UIViewController *rightPanel;

// left panel size
@property (nonatomic) CGFloat leftGapPercentage;
@property (nonatomic) CGFloat leftFixedWidth;

// right panel size
@property (nonatomic) CGFloat rightGapPercentage;
@property (nonatomic) CGFloat rightFixedWidth;

// animation
@property (nonatomic) CGFloat minimumMovePercentage;
@property (nonatomic) CGFloat maximumAnimationDuration;
@property (nonatomic) CGFloat bounceDuration;
@property (nonatomic) CGFloat bouncePercentage;

// panning
@property (nonatomic) BOOL panningLimitedToTopViewController;

@property (nonatomic, readonly) UIViewController *gestureController;

+ (UIImage *)defaultImage;

- (void)showLeftPanel:(BOOL)animated;
- (void)showRightPanel:(BOOL)animated;
- (void)showCenterPanel:(BOOL)animated;

- (void)toggleLeftPanel:(id)sender;
- (void)toggleRightPanel:(id)sender;

// subclasses may override to change panel style
- (void)styleContainer:(UIView *)container animate:(BOOL)animate duration:(NSTimeInterval)duration;
- (void)stylePanel:(UIView *)panel;

//
- (UIBarButtonItem *)leftButtonForCenterPanel;

@end
