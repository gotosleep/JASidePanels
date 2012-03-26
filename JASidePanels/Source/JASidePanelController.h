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

#pragma mark - Usage

// set the panels
@property (nonatomic, strong) UIViewController *leftPanel;   // optional
@property (nonatomic, strong) UIViewController *centerPanel; // required
@property (nonatomic, strong) UIViewController *rightPanel;  // optional

// show the panels
- (void)showLeftPanel:(BOOL)animated;
- (void)showRightPanel:(BOOL)animated;
- (void)showCenterPanel:(BOOL)animated;

// toggle them opened/closed
- (void)toggleLeftPanel:(id)sender;
- (void)toggleRightPanel:(id)sender;

#pragma mark - Look & Feel

// style
@property (nonatomic) JASidePanelStyle style; // default is JASidePanelSingleActive

// size the left panel based on % of total screen width
@property (nonatomic) CGFloat leftGapPercentage; 

// size the left panel based on this fixed size. overrides leftGapPercentage
@property (nonatomic) CGFloat leftFixedWidth;

// size the right panel based on % of total screen width
@property (nonatomic) CGFloat rightGapPercentage;

// size the right panel based on this fixed size. overrides rightGapPercentage
@property (nonatomic) CGFloat rightFixedWidth;

// by default applies a black shadow to the container. override in sublcass to change
- (void)styleContainer:(UIView *)container animate:(BOOL)animate duration:(NSTimeInterval)duration;

// by default applies rounded corners to the panel. override in sublcass to change
- (void)stylePanel:(UIView *)panel;

#pragma mark - Animation

// the minimum % of total screen width the gestureController.view must move for panGesture to succeed
@property (nonatomic) CGFloat minimumMovePercentage;

// the maximum time panel opening/closing should take. Actual time may be less if panGesture has already moved the view.
@property (nonatomic) CGFloat maximumAnimationDuration;

// how long the bounce animation should take
@property (nonatomic) CGFloat bounceDuration;

// how far the view should bounce
@property (nonatomic) CGFloat bouncePercentage;

#pragma mark - Gesture Behavior

// Determines whether the pan gesture is limited to the top ViewController in a UINavigationController/UITabBarController
@property (nonatomic) BOOL panningLimitedToTopViewController; // default is YES

// The UIViewController to apply the pan gesture to. Defaults to [self centerPanel].
@property (nonatomic, readonly) UIViewController *gestureController;

#pragma mark - Menu Buttons

// Gives you an image to use for your menu button. The image is three stacked white lines, similar to Path 2.0 or Facebook's menu button.
+ (UIImage *)defaultImage;

// Default button to place in gestureViewControllers top viewController. Override in sublcass to change look of default button
- (UIBarButtonItem *)leftButtonForCenterPanel;

#pragma mark - Nuts & Bolts

// Current state of panels. Use KVO to monitor state changes
@property (nonatomic, readonly) JASidePanelState state;

// Containers for the panels.
@property (nonatomic, strong, readonly) UIView *leftPanelContainer;
@property (nonatomic, strong, readonly) UIView *rightPanelContainer;
@property (nonatomic, strong, readonly) UIView *centerPanelContainer;

@end
