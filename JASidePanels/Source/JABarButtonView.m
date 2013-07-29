//
//  JABarButtonView.m
//  JASidePanels
//
//  Created by David Anderson on 2013-07-29.
//
//

#import "JABarButtonView.h"

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
}

@end
