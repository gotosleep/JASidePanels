//
//  JABarButtonView.m
//  JASidePanels
//
//  Created by David Anderson on 2013-07-29.
//
//

#import "JABarButtonView.h"

static const CGFloat NavigationBarDefaultButtonPadding = 7.0;

@implementation JABarButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setGradientView:(UIView *)gradientView {
    if (gradientView == _gradientView) {
        return;
    }
    [_gradientView removeFromSuperview];
    _gradientView = gradientView;
    [self addSubview:gradientView];
}

- (void)setLeftCustomButton:(UIButton *)leftCustomButton {
    if (leftCustomButton == _leftCustomButton) {
        return;
    }
    [_leftCustomButton removeFromSuperview];
    _leftCustomButton = leftCustomButton;
    [self addSubview:leftCustomButton];
    
    [self updateFrameToFitAllButtons];
}

- (void)setRightCustomButton:(UIButton *)rightCustomButton {
    if (rightCustomButton == _rightCustomButton) {
        return;
    }
    [_rightCustomButton removeFromSuperview];
    _rightCustomButton = rightCustomButton;
    [self addSubview:rightCustomButton];
    
    [self updateFrameToFitAllButtons];
}

- (void)updateFrameToFitAllButtons{
    //Update the frame of the button view to fit both left and right objects
    CGFloat width = 0.0;
    if(self.leftCustomButton && self.rightCustomButton){
        width = (self.leftCustomButton.frame.origin.x + self.leftCustomButton.frame.size.width) + (self.rightCustomButton.frame.origin.x + self.rightCustomButton.frame.size.width) + NavigationBarDefaultButtonPadding;
    }else if(self.leftCustomButton && !self.rightCustomButton){
        width = (self.leftCustomButton.frame.origin.x + self.leftCustomButton.frame.size.width);
    }else if(!self.leftCustomButton && self.rightCustomButton){
        width = (self.rightCustomButton.frame.origin.x + self.rightCustomButton.frame.size.width);
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

@end
