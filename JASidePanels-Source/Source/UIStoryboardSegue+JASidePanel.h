//
//  UIStoryboardSegue+JASidePanel.h
//
//  Created by Brian McIntyre on 2013-05-11.
//
//

#import <UIKit/UIKit.h>

@interface UIStoryboardSegue (JASidePanel)

@end

// This will allow the class to be defined on a storyboard
#pragma mark - JASidePanelViewSegue

@interface JASidePanelViewSegue : UIStoryboardSegue

@property (strong) void(^performBlock)( JASidePanelViewSegue* segue, UIViewController* svc, UIViewController* dvc );

@end
