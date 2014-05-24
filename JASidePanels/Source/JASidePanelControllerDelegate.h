//
//  JASidePanelControllerDelegate.h
//  JASidePanels
//
//  Created by Adam Eri on 24/05/2014.
//
//

#import <Foundation/Foundation.h>

@class JASidePanelController;

@protocol JASidePanelControllerDelegate <NSObject>

@optional

#pragma mark - Customisation

/**
 *  Delegate method for setting the border radius of the panels. Default is 6.0f.
 *
 *  @param panel Panel to set the border radius for.
 *
 *  @return Border radius as CGFloat
 */
- (CGFloat)borderRadiusForPanel:(UIView *)panel;

/**
 *  Delegate method for setting the UIBarButton icon for showing the left panel. See +defaultImage method for the default image.
 *
 *  @return UImage to use as icon on nagivation bar.
 */
- (UIImage *)imageForLeftButtonForCenterPanel;

#pragma mark - Event Notifications

/**
 *  Delegate method called when the left panel is about to be shown.
 *
 *  @param panelController Instance of JASidePanelController
 *  @param animated        BOOL. Indicates wether the transation will be animated.
 */
- (void)panelController:(JASidePanelController *)panelController willShowLeftPanelAnimated:(BOOL)animated;

/**
 *  Delegate method called when the right panel is about to be shown.
 *
 *  @param panelController Instance of JASidePanelController
 *  @param animated        BOOL. Indicates wether the transation will be animated.
 */
- (void)panelController:(JASidePanelController *)panelController willShowRightPanelAnimated:(BOOL)animated;

/**
 *  Delegate method called when the center panel is about to be shown.
 *
 *  @param panelController Instance of JASidePanelController
 *  @param animated        BOOL. Indicates wether the transation will be animated.
 */
- (void)panelController:(JASidePanelController *)panelController willShowCenterPanelAnimated:(BOOL)animated;

@end
