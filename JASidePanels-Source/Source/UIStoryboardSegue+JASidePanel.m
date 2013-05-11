//
//  UIStoryboardSegue+JASidePanel.m
//
//  Created by Brian McIntyre on 2013-05-11.
//
//

#import "UIStoryboardSegue+JASidePanel.h"

@implementation UIStoryboardSegue (JASidePanel)

@end

#pragma mark - JASidePanelViewSegue Class

@implementation JASidePanelViewSegue

- (void)perform
{
    if ( _performBlock != nil )
    {
        _performBlock( self, self.sourceViewController, self.destinationViewController );
    }
}

@end


