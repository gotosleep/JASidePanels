//
//  JAViewController.m
//  JASidePanels
//
//  Created by Jesse Andersen on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "JASidePanelController.h"

typedef enum _JASidePanelState {
	JASidePanelCenterVisible = 1,
	JASidePanelLeftVisible,
	JASidePanelRightVisible
} JASidePanelState;

@interface JASidePanelController() {
	CGRect _centerPanelRestingFrame;		
	CGPoint _locationBeforePan;
}

@property (nonatomic) JASidePanelState state;

// internal helpers
- (UIViewController *)_gestureController:(UIViewController *)parent;
- (BOOL)_validateThreshold:(CGFloat)movement;
- (void)_activateLeftPanel;
- (void)_activateRightPanel;

// gestures
- (void)_handlePan:(UIGestureRecognizer *)sender;
- (void)_completePan:(CGFloat)deltaX;
- (void)_undoPan:(CGFloat)deltaX;

// showing panels
- (void)_showLeftPanel:(BOOL)animated bounce:(BOOL)shouldBounce;
- (void)_showCenterPanel:(BOOL)animated bounce:(BOOL)shouldBounce;
- (void)_showRightPanel:(BOOL)animated bounce:(BOOL)shouldBounce;

// animation
- (CGFloat)_calculatedDuration;
- (void)_animateCenterPanel:(BOOL)shouldBounce completion:(void (^)(BOOL finished))completion;

@end

@implementation JASidePanelController

@synthesize state = _state;

@synthesize leftPanel = _leftPanel;
@synthesize centerPanel = _centerPanel;
@synthesize rightPanel = _rightPanel;

@synthesize leftGapPercentage = _leftGapPercentage;
@synthesize rightGapPercentage = _rightGapPercentage;

@synthesize minimumMovePercentage = _minimumMovePercentage;
@synthesize maximumAnimationDuration = _maximumAnimationDuration;
@synthesize bounceDuration = _bounceDuration;

#pragma mark - Icon

+ (UIImage *)defaultImage {
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(20.f, 13.f), NO, 0.0f);
	
	[[UIColor blackColor] setFill];
	[[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 20, 1)] fill];
	[[UIBezierPath bezierPathWithRect:CGRectMake(0, 5, 20, 1)] fill];
	[[UIBezierPath bezierPathWithRect:CGRectMake(0, 10, 20, 1)] fill];

	[[UIColor whiteColor] setFill];
	[[UIBezierPath bezierPathWithRect:CGRectMake(0, 1, 20, 2)] fill];
	[[UIBezierPath bezierPathWithRect:CGRectMake(0, 6,  20, 2)] fill];
	[[UIBezierPath bezierPathWithRect:CGRectMake(0, 11, 20, 2)] fill];   
	
	UIImage *iconImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return iconImage;
}

#pragma mark - NSObject

- (id)init {
	if (self = [super init]) {
		self.leftGapPercentage = 0.2f;
		self.rightGapPercentage = 0.2f;
		self.minimumMovePercentage = 0.2f;
		self.maximumAnimationDuration = 0.2f;
		self.bounceDuration = 0.1f;
	}
	return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.state = JASidePanelCenterVisible;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	_centerPanelRestingFrame.size = self.view.bounds.size;
	switch (self.state) {
		case JASidePanelLeftVisible:
			[self _showLeftPanel:NO bounce:NO];
			break;
		case JASidePanelRightVisible:
			[self _showRightPanel:NO bounce:NO];
			break;
		default:
			break;
	}
}

#pragma mark - Panels

- (void)setCenterPanel:(UIViewController *)centerPanel {
	if (centerPanel != _centerPanel) {
		CGRect frame = _centerPanel ? _centerPanel.view.frame : self.view.bounds;
		[_centerPanel willMoveToParentViewController:nil];
		[_centerPanel removeFromParentViewController];
		_centerPanel = centerPanel;
		[self addChildViewController:_centerPanel];
		[self.view addSubview:_centerPanel.view];
		
		UIViewController *gestureController = [self _gestureController:_centerPanel];
		
		UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_handlePan:)];
		panGesture.maximumNumberOfTouches = 1;
		panGesture.minimumNumberOfTouches = 1;	
		[gestureController.view addGestureRecognizer:panGesture];
		
		_centerPanel.view.frame = frame;	
		_centerPanel.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_centerPanelRestingFrame = _centerPanel.view.frame;
		
		_centerPanel.view.layer.shadowColor = [UIColor blackColor].CGColor;
		_centerPanel.view.layer.shadowRadius = 10.0f;
		_centerPanel.view.layer.shadowOpacity = 0.5f;
		_centerPanel.view.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:_centerPanel.view.bounds cornerRadius:0.0f].CGPath;
		
		if (!gestureController.navigationItem.leftBarButtonItem) {
			gestureController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[self class] defaultImage] style:UIBarButtonItemStylePlain target:self action:@selector(_leftButtonTouched:)];
		}
	}
}

- (void)setLeftPanel:(UIViewController *)leftPanel {
	if (leftPanel != _leftPanel) {
		[_leftPanel willMoveToParentViewController:nil];
		[_leftPanel removeFromParentViewController];
		_leftPanel = leftPanel;
		[self addChildViewController:_leftPanel];
		_leftPanel.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	}
}

- (void)setRightPanel:(UIViewController *)rightPanel {
	if (rightPanel != _rightPanel) {
		[_rightPanel willMoveToParentViewController:nil];
		[_rightPanel removeFromParentViewController];
		_rightPanel = rightPanel;
		[self addChildViewController:_rightPanel];
		_rightPanel.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	}
}

#pragma mark - Gesture Recognizer

- (void)_handlePan:(UIGestureRecognizer *)sender {
	if ([sender isKindOfClass:[UIPanGestureRecognizer class]]) {
		UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)sender;
		
		if (pan.state == UIGestureRecognizerStateBegan) {
			_locationBeforePan = self.centerPanel.view.frame.origin;
		}
		
		CGPoint translate = [pan translationInView:self.centerPanel.view];
		CGRect frame = _centerPanelRestingFrame;
		frame.origin.x += [self _correctMovement:translate.x];
		self.centerPanel.view.frame = frame;
		
		if (frame.origin.x > 0.0f) {
			[self _activateLeftPanel];
		} else if(frame.origin.x < 0.0f) {
			[self _activateRightPanel];
		}
		
		if (sender.state == UIGestureRecognizerStateEnded) {
			CGFloat deltaX =  frame.origin.x - _locationBeforePan.x;			
			if ([self _validateThreshold:deltaX]) {
				[self _completePan:deltaX];
			} else {
				[self _undoPan:deltaX];
			}
		}
	}
}

- (void)_completePan:(CGFloat)deltaX {
	switch (self.state) {
		case JASidePanelCenterVisible:
			if (deltaX > 0.0f) {
				[self _showLeftPanel:YES bounce:YES];
			} else {
				[self _showRightPanel:YES bounce:YES];
			}
			break;
		case JASidePanelLeftVisible:
		case JASidePanelRightVisible:
			[self _showCenterPanel:YES bounce:YES];
		default:
			break;
	}	
}

- (void)_undoPan:(CGFloat)deltaX {
	switch (self.state) {
		case JASidePanelCenterVisible:
			[self _showCenterPanel:YES bounce:NO];
			break;
		case JASidePanelLeftVisible:
			[self _showLeftPanel:YES bounce:NO];
			break;
		case JASidePanelRightVisible:
			[self _showRightPanel:YES bounce:NO];
		default:
			break;
	}
}

#pragma mark - Internal Methods

- (UIViewController *)_gestureController:(UIViewController *)parent {
	UIViewController *result = parent;
	if ([parent isKindOfClass:[UINavigationController class]]) {
		UINavigationController *nav = (UINavigationController *)parent;
		if ([nav.viewControllers count] > 0) {
			result = [nav.viewControllers objectAtIndex:0];
		}
	}
	return result;
}


- (CGFloat)_correctMovement:(CGFloat)movement {	
	if (self.state == JASidePanelCenterVisible) {
		CGFloat position = _centerPanelRestingFrame.origin.x + movement;		
		if ((position > 0.0f && !self.leftPanel) || (position < 0.0f && !self.rightPanel)) {
			return 0.0f;
		}
	}
	return movement;
}

- (BOOL)_validateThreshold:(CGFloat)movement {
	CGFloat minimum = floorf(self.view.bounds.size.width * self.minimumMovePercentage);
	switch (self.state) {
		case JASidePanelLeftVisible:
			return movement <= -minimum;
		case JASidePanelCenterVisible:
			return abs(movement) >= minimum;
		case JASidePanelRightVisible:
			return movement >= minimum;
		default:
			break;
	}
	return NO;
}

- (void)_activateLeftPanel {
	if ( !_leftPanel.view.superview) {
		[_rightPanel.view removeFromSuperview];
		_leftPanel.view.frame = self.view.bounds;
		[self.view addSubview:_leftPanel.view];
		[self.view bringSubviewToFront:_centerPanel.view];
	}
}

- (void)_activateRightPanel {
	if ( !_rightPanel.view.superview) {
		[_leftPanel.view removeFromSuperview];
		_rightPanel.view.frame = self.view.bounds;
		[self.view addSubview:_rightPanel.view];
		[self.view bringSubviewToFront:_centerPanel.view];
	}
}

#pragma mark - Animation

- (CGFloat)_calculatedDuration {
	CGFloat remaining = abs(self.centerPanel.view.frame.origin.x - _centerPanelRestingFrame.origin.x);	
	CGFloat max = _locationBeforePan.x == _centerPanelRestingFrame.origin.x ? remaining : abs(_locationBeforePan.x - _centerPanelRestingFrame.origin.x);
	return max > 0.0f ? self.maximumAnimationDuration * (remaining / max) : self.maximumAnimationDuration;
}

- (void)_animateCenterPanel:(BOOL)shouldBounce completion:(void (^)(BOOL finished))completion {
	CGFloat bounceDistance = (_centerPanelRestingFrame.origin.x - self.centerPanel.view.frame.origin.x) * .05f;
	
	[UIView animateWithDuration:[self _calculatedDuration] delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
		self.centerPanel.view.frame = _centerPanelRestingFrame;				
	} completion:^(BOOL finished) {
		if (shouldBounce) {
			// make sure correct panel is displayed under the bounce
			if (bounceDistance > 0.0f) {
				[self _activateLeftPanel];
			} else {
				[self _activateRightPanel];
			}
			// animate the bounce
			[UIView animateWithDuration:self.bounceDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
				CGRect bounceFrame = _centerPanelRestingFrame;
				bounceFrame.origin.x += bounceDistance;
				self.centerPanel.view.frame = bounceFrame;
			} completion:^(BOOL finished) {
				[UIView animateWithDuration:self.bounceDuration delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
					self.centerPanel.view.frame = _centerPanelRestingFrame;				
				} completion:completion];
			}];
		} else if (completion) {
			completion(finished);
		}
	}];
}

#pragma mark - Showing Panels

- (void)_showLeftPanel:(BOOL)animated bounce:(BOOL)shouldBounce {
	self.state = JASidePanelLeftVisible;
	[self _activateLeftPanel];
	CGFloat gap = floorf(self.view.bounds.size.width * self.leftGapPercentage);
	_centerPanelRestingFrame.origin.x = self.view.bounds.size.width - gap;
		
	if (animated) {
		[self _animateCenterPanel:shouldBounce completion:nil];
	} else {
		self.centerPanel.view.frame = _centerPanelRestingFrame;			
	}
}

- (void)_showRightPanel:(BOOL)animated bounce:(BOOL)shouldBounce {
	self.state = JASidePanelRightVisible;
	[self _activateRightPanel];
	CGFloat gap = floorf(self.view.bounds.size.width * self.rightGapPercentage);
	_centerPanelRestingFrame.origin.x = -self.view.bounds.size.width + gap;
	
	if (animated) {
		[self _animateCenterPanel:shouldBounce completion:nil];
	} else {
		self.centerPanel.view.frame = _centerPanelRestingFrame;			
	}
}

- (void)_showCenterPanel:(BOOL)animated bounce:(BOOL)shouldBounce {
	self.state = JASidePanelCenterVisible;
	_centerPanelRestingFrame.origin.x = 0.0f;
	
	if (animated) {
		[self _animateCenterPanel:shouldBounce completion:^(BOOL finished) {
			[_leftPanel.view removeFromSuperview];
			[_rightPanel.view removeFromSuperview];
		}];
	} else {
		self.centerPanel.view.frame = _centerPanelRestingFrame;		
		[_leftPanel.view removeFromSuperview];
		[_rightPanel.view removeFromSuperview];
	}
}

#pragma mark - Public Methods

- (void)showLeftPanel:(BOOL)animated {
	[self _showLeftPanel:animated bounce:NO];
}

- (void)showRightPanel:(BOOL)animated {
	[self _showRightPanel:animated bounce:NO];
}

- (void)showCenterPanel:(BOOL)animated {
	[self _showCenterPanel:animated bounce:NO];
}

#pragma mark - Buttons

- (void)_leftButtonTouched:(id)sender {
	if (self.state == JASidePanelLeftVisible) {
		[self _showCenterPanel:YES bounce:NO];
	} else if (self.state == JASidePanelCenterVisible) {
		[self _showLeftPanel:YES bounce:NO];
	}
}

@end
