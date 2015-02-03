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

#import <Foundation/Foundation.h>

@class JASidePanelController;

@protocol JASidePanelControllerDelegate <NSObject>

@optional

#pragma mark - Panel Events

/**
 *  Delegate method called when the left panel is about to be shown.
 *
 *  @param panelController  Instance of JASidePanelController
 *  @param animated         BOOL. Indicates whether the transation will be animated.
 *  @param bounce           BOOL. Indicates whether the transation will have a bounce animation.
 */
- (void)panelController:(JASidePanelController *)panelController willShowLeftPanelAnimated:(BOOL)animated bounce:(BOOL)bounce;

/**
 *  Delegate method called when the left panel was shown.
 *
 *  @param panelController  Instance of JASidePanelController
 *  @param animated         BOOL. Indicates whether the transation was animated.
 *  @param bounce           BOOL. Indicates whether the transation had a bounce animation.
 */
- (void)panelController:(JASidePanelController *)panelController didShowLeftPanelAnimated:(BOOL)animated bounce:(BOOL)bounce;


/**
 *  Delegate method called when the right panel is about to be shown.
 *
 *  @param panelController  Instance of JASidePanelController
 *  @param animated         BOOL. Indicates whether the transation will be animated.
 *  @param bounce           BOOL. Indicates whether the transation will have a bounce animation.
 */
- (void)panelController:(JASidePanelController *)panelController willShowRightPanelAnimated:(BOOL)animated bounce:(BOOL)bounce;

/**
 *  Delegate method called when the right panel was shown.
 *
 *  @param panelController  Instance of JASidePanelController
 *  @param animated         BOOL. Indicates whether the transation was animated.
 *  @param bounce           BOOL. Indicates whether the transation had a bounce animation.
 */
- (void)panelController:(JASidePanelController *)panelController didShowRightPanelAnimated:(BOOL)animated bounce:(BOOL)bounce;


/**
 *  Delegate method called when the center panel is about to be shown.
 *
 *  @param panelController  Instance of JASidePanelController
 *  @param animated         BOOL. Indicates whether the transation will be animated.
 *  @param bounce           BOOL. Indicates whether the transation will have a bounce animation.
 */
- (void)panelController:(JASidePanelController *)panelController willShowCenterPanelAnimated:(BOOL)animated bounce:(BOOL)bounce;

/**
 *  Delegate method called when the center panel was shown.
 *
 *  @param panelController  Instance of JASidePanelController
 *  @param animated         BOOL. Indicates whether the transation was animated.
 *  @param bounce           BOOL. Indicates whether the transation had a bounce animation.
 */
- (void)panelController:(JASidePanelController *)panelController didShowCenterPanelAnimated:(BOOL)animated bounce:(BOOL)bounce;

@end
