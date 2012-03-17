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
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

// center panel
- (void)_swapCenter:(UIViewController *)previous with:(UIViewController *)next;

// internal helpers
- (BOOL)_validateThreshold:(CGFloat)movement;

// panel loading
- (void)_loadCenterPanel;
- (void)_loadLeftPanel;
- (void)_loadRightPanel;

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

@synthesize tapGesture = _tapGesture;

@synthesize state = _state;

@synthesize leftPanel = _leftPanel;
@synthesize centerPanel = _centerPanel;
@synthesize rightPanel = _rightPanel;

@synthesize leftGapPercentage = _leftGapPercentage;
@synthesize rightGapPercentage = _rightGapPercentage;

@synthesize minimumMovePercentage = _minimumMovePercentage;
@synthesize maximumAnimationDuration = _maximumAnimationDuration;
@synthesize bounceDuration = _bounceDuration;
@synthesize bouncePercentage = _bouncePercentage;

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
		self.minimumMovePercentage = 0.15f;
		self.maximumAnimationDuration = 0.2f;
		self.bounceDuration = 0.1f;
		self.bouncePercentage = 0.075f;
	}
	return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.state = JASidePanelCenterVisible;
	
	[self _swapCenter:nil with:_centerPanel];
}

- (void)viewDidUnload {
    [super viewDidUnload];
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
	UIViewController *previous = _centerPanel;
	if (centerPanel != _centerPanel) {
		_centerPanel = centerPanel;
	}
	if (self.isViewLoaded && self.state == JASidePanelCenterVisible) {
		[self _swapCenter:previous with:_centerPanel];
	} else if (self.isViewLoaded) {
		[UIView animateWithDuration:0.2f animations:^{
			// first move the centerPanel offscreen
			CGFloat x = self.state == JASidePanelLeftVisible ? self.view.bounds.size.width : -self.view.bounds.size.width;
			_centerPanelRestingFrame.origin.x = x;
			previous.view.frame = _centerPanelRestingFrame;
		} completion:^(BOOL finished) {
			[self _swapCenter:previous with:_centerPanel];
			[self _showCenterPanel:YES bounce:NO];
		}];
	}
}

- (void)_swapCenter:(UIViewController *)previous with:(UIViewController *)next {
	if (previous != next) {
		[previous willMoveToParentViewController:nil];
		[previous.view removeFromSuperview];
		[previous removeFromParentViewController];
		
		CGRect frame = previous ? previous.view.frame : self.view.bounds;
		next.view.frame = frame;
		_centerPanelRestingFrame = frame;
		if (next) {
			[self _loadCenterPanel];
			[self addChildViewController:next];
			[self.view addSubview:next.view];
		}
	}
}

- (void)setLeftPanel:(UIViewController *)leftPanel {
	if (leftPanel != _leftPanel) {
		[_leftPanel willMoveToParentViewController:nil];
		[_leftPanel.view removeFromSuperview];
		[_leftPanel removeFromParentViewController];
		_leftPanel = leftPanel;
		[self addChildViewController:_leftPanel];
	}
}

- (void)setRightPanel:(UIViewController *)rightPanel {
	if (rightPanel != _rightPanel) {
		[_rightPanel willMoveToParentViewController:nil];
		[_rightPanel.view removeFromSuperview];
		[_rightPanel removeFromParentViewController];
		_rightPanel = rightPanel;
		[self addChildViewController:_rightPanel];
	}
}

#pragma mark - Gesture Recognizer

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
	if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
		UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
		CGPoint translate = [pan translationInView:self.centerPanel.view];
		return translate.x != 0 && ((translate.y / translate.x) < 1.0f);
	}
	return NO;
}

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
			[self _loadLeftPanel];
		} else if(frame.origin.x < 0.0f) {
			[self _loadRightPanel];
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
			[self _showCenterPanel:YES bounce:_rightPanel != nil];
			break;
		case JASidePanelRightVisible:
			[self _showCenterPanel:YES bounce:_leftPanel != nil];
			break;
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

- (void)setTapGesture:(UITapGestureRecognizer *)tapGesture {
	if (tapGesture != _tapGesture) {
		[_tapGesture.view removeGestureRecognizer:_tapGesture];
		_tapGesture = tapGesture;
	}
}

- (void)_centerPanelTapped:(UIGestureRecognizer *)gesture {
	[self _showCenterPanel:YES bounce:NO];
}

#pragma mark - Internal Methods

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
			return fabsf(movement) >= minimum;
		case JASidePanelRightVisible:
			return movement >= minimum;
		default:
			break;
	}
	return NO;
}

#pragma mark - Loading Panels

- (void)_loadCenterPanel {
	UIViewController *gestureController = self.gestureController;
	UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_handlePan:)];
	panGesture.delegate = self;
	panGesture.maximumNumberOfTouches = 1;
	panGesture.minimumNumberOfTouches = 1;	
	[gestureController.view addGestureRecognizer:panGesture];
	
	_centerPanel.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_centerPanel.view.layer.shadowColor = [UIColor blackColor].CGColor;
	_centerPanel.view.layer.shadowRadius = 10.0f;
	_centerPanel.view.layer.shadowOpacity = 0.5f;
	_centerPanel.view.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:_centerPanel.view.bounds cornerRadius:0.0f].CGPath;
	
	if (!gestureController.navigationItem.leftBarButtonItem) {
		UIBarButtonItem *button = [self leftButtonForCenterPanel];
		button.target = self;
		button.action = @selector(_leftButtonTouched:);
		gestureController.navigationItem.leftBarButtonItem = button;
	}
}

- (void)_loadLeftPanel {
	if ( !_leftPanel.view.superview) {
		[_rightPanel.view removeFromSuperview];
		_leftPanel.view.frame = self.view.bounds;
		_leftPanel.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[self.view addSubview:_leftPanel.view];
		[self.view bringSubviewToFront:_centerPanel.view];
	}
}

- (void)_loadRightPanel {
	if ( !_rightPanel.view.superview) {
		[_leftPanel.view removeFromSuperview];
		_rightPanel.view.frame = self.view.bounds;
		_rightPanel.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[self.view addSubview:_rightPanel.view];
		[self.view bringSubviewToFront:_centerPanel.view];
	}
}

#pragma mark - Animation

- (CGFloat)_calculatedDuration {
	CGFloat remaining = fabsf(self.centerPanel.view.frame.origin.x - _centerPanelRestingFrame.origin.x);	
	CGFloat max = _locationBeforePan.x == _centerPanelRestingFrame.origin.x ? remaining : fabsf(_locationBeforePan.x - _centerPanelRestingFrame.origin.x);
	return max > 0.0f ? self.maximumAnimationDuration * (remaining / max) : self.maximumAnimationDuration;
}

- (void)_animateCenterPanel:(BOOL)shouldBounce completion:(void (^)(BOOL finished))completion {
	CGFloat bounceDistance = (_centerPanelRestingFrame.origin.x - self.centerPanel.view.frame.origin.x) * self.bouncePercentage;
	
	[UIView animateWithDuration:[self _calculatedDuration] delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
		self.centerPanel.view.frame = _centerPanelRestingFrame;				
	} completion:^(BOOL finished) {
		if (shouldBounce) {
			// make sure correct panel is displayed under the bounce
			if (self.state == JASidePanelCenterVisible) {
				if (bounceDistance > 0.0f) {
					[self _loadLeftPanel];
				} else {
					[self _loadRightPanel];
				}
			}
			// animate the bounce
			[UIView animateWithDuration:self.bounceDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
				CGRect bounceFrame = _centerPanelRestingFrame;
				bounceFrame.origin.x += bounceDistance;
				self.centerPanel.view.frame = bounceFrame;
			} completion:^(BOOL finished2) {
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
	[self _loadLeftPanel];
	CGFloat gap = floorf(self.view.bounds.size.width * self.leftGapPercentage);
	_centerPanelRestingFrame.origin.x = self.view.bounds.size.width - gap;
		
	if (animated) {
		[self _animateCenterPanel:shouldBounce completion:nil];
	} else {
		self.centerPanel.view.frame = _centerPanelRestingFrame;			
	}
	
	self.tapGesture = [[UITapGestureRecognizer alloc] init];
	[self.tapGesture addTarget:self action:@selector(_centerPanelTapped:)];
	[self.gestureController.view addGestureRecognizer:self.tapGesture];
}

- (void)_showRightPanel:(BOOL)animated bounce:(BOOL)shouldBounce {
	self.state = JASidePanelRightVisible;
	[self _loadRightPanel];
	CGFloat gap = floorf(self.view.bounds.size.width * self.rightGapPercentage);
	_centerPanelRestingFrame.origin.x = -self.view.bounds.size.width + gap;
	
	if (animated) {
		[self _animateCenterPanel:shouldBounce completion:nil];
	} else {
		self.centerPanel.view.frame = _centerPanelRestingFrame;			
	}
	
	self.tapGesture = [[UITapGestureRecognizer alloc] init];
	[self.tapGesture addTarget:self action:@selector(_centerPanelTapped:)];
	[self.gestureController.view addGestureRecognizer:self.tapGesture];
}

- (void)_showCenterPanel:(BOOL)animated bounce:(BOOL)shouldBounce {
	self.state = JASidePanelCenterVisible;
	_centerPanelRestingFrame.origin.x = 0.0f;
	
	self.tapGesture = nil;
	
	if (animated) {
		[self _animateCenterPanel:shouldBounce completion:^(BOOL finished) {
			if (_leftPanel.isViewLoaded) {
				[_leftPanel.view removeFromSuperview];
			}
			if (_rightPanel.isViewLoaded) {
				[_rightPanel.view removeFromSuperview];
			}
		}];
	} else {
		self.centerPanel.view.frame = _centerPanelRestingFrame;		
		if (_leftPanel.isViewLoaded) {
			[_leftPanel.view removeFromSuperview];
		}
		if (_rightPanel.isViewLoaded) {
			[_rightPanel.view removeFromSuperview];
		}
	}
}

#pragma mark - Public Methods

- (UIBarButtonItem *)leftButtonForCenterPanel {
	return [[UIBarButtonItem alloc] initWithImage:[[self class] defaultImage] style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (UIViewController *)gestureController {
	UIViewController *result = self.centerPanel;
	if ([result isKindOfClass:[UINavigationController class]]) {
		UINavigationController *nav = (UINavigationController *)result;
		if ([nav.viewControllers count] > 0) {
			result = [nav.viewControllers objectAtIndex:0];
		}
	}
	return result;
}

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
