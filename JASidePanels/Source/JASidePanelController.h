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
