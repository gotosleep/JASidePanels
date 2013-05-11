//
//  MenuCell.h
//
//  Created by Brian McIntyre on 2013-02-10.
//
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell

@property (nonatomic, strong)	IBOutlet UILabel *title;

+(NSString *) cellIdentifier;

@end
