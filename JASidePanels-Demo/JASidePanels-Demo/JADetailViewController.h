//
//  DetailViewController.h
//  JASidePanels-Demo
//
//  Created by Andrey Yastrebov on 22.08.13.
//  Copyright (c) 2013 AgileFusion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JADetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (assign, nonatomic) BOOL hideMaster;
@end
