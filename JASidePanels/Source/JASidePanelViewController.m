//
//  JAViewController.m
//  JASidePanels
//
//  Created by Jesse Andersen on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "JASidePanelViewController.h"

typedef enum _JASidePanelState {
	JASidePanelCenterVisible = 1,
	JASidePanelLeftVisible,
	JASidePanelRightVisible
} JASidePanelState;

@interface JASidePanelViewController() {
	CGRect _centerPanelRestingFrame;		
	CGPoint _locationBeforePan;
}

@property (nonatomic) JASidePanelState state;

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

@implementation JASidePanelViewController

@synthesize state = _state;

@synthesize leftPanel = _leftPanel;
@synthesize centerPanel = _centerPanel;
@synthesize rightPanel = _rightPanel;

@synthesize leftGapPercentage = _leftGapPercentage;
@synthesize rightGapPercentage = _rightGapPercentage;

@synthesize minimumMovePercentage = _minimumMovePercentage;
@synthesize maximumAnimationDuration = _maximumAnimationDuration;
@synthesize bounceDuration = _bounceDuration;

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
	
	self.state = JASidePanelCenterVisible;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
	    return YES;
	}
}

#pragma mark - Panels

- (void)setLeftPanel:(UIViewController *)leftPanel {
	if (leftPanel != _leftPanel) {
		[_leftPanel willMoveToParentViewController:nil];
		[_leftPanel removeFromParentViewController];
		_leftPanel = leftPanel;
		[self addChildViewController:_leftPanel];
		_leftPanel.view.frame = self.view.bounds;
	}
}

- (void)setCenterPanel:(UIViewController *)centerPanel {
	if (centerPanel != _centerPanel) {
		[_centerPanel willMoveToParentViewController:nil];
		[_centerPanel removeFromParentViewController];
		_centerPanel = centerPanel;
		[self addChildViewController:_centerPanel];
		[self.view addSubview:_centerPanel.view];
		
		UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_handlePan:)];
		panGesture.maximumNumberOfTouches = 1;
		panGesture.minimumNumberOfTouches = 1;	
		[_centerPanel.view addGestureRecognizer:panGesture];
		
		_centerPanel.view.frame = self.view.bounds;		
		_centerPanelRestingFrame = _centerPanel.view.frame;
		
		_centerPanel.view.layer.shadowColor = [UIColor blackColor].CGColor;
		_centerPanel.view.layer.shadowRadius = 10.0f;
		_centerPanel.view.layer.shadowOpacity = 0.5f;
		_centerPanel.view.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:_centerPanel.view.bounds cornerRadius:0.0f].CGPath;
	}
}

- (void)setRightPanel:(UIViewController *)rightPanel {
	if (rightPanel != _rightPanel) {
		[_rightPanel willMoveToParentViewController:nil];
		[_rightPanel removeFromParentViewController];
		_rightPanel = rightPanel;
		[self addChildViewController:_rightPanel];
		_rightPanel.view.frame = self.view.bounds;
	}
}

#pragma mark - Gesture Recognizer

- (void)_handlePan:(UIGestureRecognizer *)sender {
	if ([sender isKindOfClass:[UIPanGestureRecognizer class]]) {
		UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)sender;
		
		if (sender.state == UIGestureRecognizerStateBegan) {
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

- (CGFloat)_correctMovement:(CGFloat)movement {	
	if (self.state == JASidePanelCenterVisible) {
		CGFloat position = _centerPanelRestingFrame.origin.x + movement;		
		if (position > 0.0f && !self.leftPanel) {
			return 0.0f;
		} else if (position < 0.0f && !self.rightPanel) {
			return 0.0f;
		}
	}
	return movement;
}

- (BOOL)_validateThreshold:(CGFloat)movement {
	CGFloat minimum = floorf(self.view.frame.size.width * self.minimumMovePercentage);
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
		[self.view addSubview:_leftPanel.view];
		[self.view bringSubviewToFront:_centerPanel.view];
	}
}

- (void)_activateRightPanel {
	if ( !_rightPanel.view.superview) {
		[_leftPanel.view removeFromSuperview];
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
	CGFloat gap = floorf(self.view.frame.size.width * self.leftGapPercentage);
	_centerPanelRestingFrame.origin.x = self.view.frame.size.width - gap;
		
	if (animated) {
		[self _animateCenterPanel:shouldBounce completion:nil];
	} else {
		self.centerPanel.view.frame = _centerPanelRestingFrame;			
	}
}

- (void)_showRightPanel:(BOOL)animated bounce:(BOOL)shouldBounce {
	self.state = JASidePanelRightVisible;
	[self _activateRightPanel];
	CGFloat gap = floorf(self.view.frame.size.width * self.rightGapPercentage);
	_centerPanelRestingFrame.origin.x = -self.view.frame.size.width + gap;
	
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

@end
