//
//  MySidePanelController.m
//
//  Created by Brian McIntyre on 2013-05-10.
//
//

#import "MySidePanelController.h"

@interface MySidePanelController ()

@end

@implementation MySidePanelController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		[self awakeFromNib];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self awakeFromNib];
	}
	return self;
}

-(void)awakeFromNib{
	UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"leftViewController"];
	controller.view.frame = CGRectMake(0, 0, 320, controller.view.frame.size.height);
	[self setLeftPanel:controller];
	
	controller = [self.storyboard instantiateViewControllerWithIdentifier:@"centerViewController"];
	[self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"centerViewController"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.style = JASidePanelSingleActive;
	self.leftFixedWidth = 260.0f;
	self.shouldResizeLeftPanel = YES;
    //self.leftGapPercentage = 0.8f;
    self.minimumMovePercentage = 0.15f;
    self.maximumAnimationDuration = 0.2f;
    self.bounceDuration = 0.1f;
    self.bouncePercentage = 0.075f;
    self.panningLimitedToTopViewController = YES;
    self.recognizesPanGesture = YES;
    self.allowLeftOverpan = YES;
    self.bounceOnSidePanelOpen = YES;
    self.bounceOnSidePanelClose = NO;
    self.bounceOnCenterPanelChange = YES;
    self.shouldDelegateAutorotateToVisiblePanel = YES;
    self.allowLeftSwipe = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
