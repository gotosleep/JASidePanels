//
//  JAFoggyContainerView.m
//  JASidePanels
//
//  Created by Artyom Devyatov on 24.02.16.
//
//

#import "JAFoggyContainerView.h"

@interface JAFoggyContainerView () {
    UIView *_fogView;
}

@end

@implementation JAFoggyContainerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *fogView = [[UIView alloc] initWithFrame:self.bounds];
        fogView.userInteractionEnabled = NO;
        fogView.backgroundColor = [UIColor blackColor];
        fogView.alpha = 0.7f;
        [self insertSubview:fogView atIndex:0];
        _fogView = fogView;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    CGFloat oldX = self.frame.origin.x;
    [super setFrame:frame];

    CGFloat pan = frame.origin.x;
    CGFloat deltaX = fabs(pan - oldX);

    [self bringSubviewToFront:_fogView];

    if (deltaX < self.bounds.size.width / 2.0f) {
        [self handlePan:pan];
    } else {
        [self handleLongPan:pan];
    }
}

- (void)handlePan:(CGFloat)pan {
    _fogView.alpha = pan / self.bounds.size.width;
}

- (void)handleLongPan:(CGFloat)pan {
    [UIView animateWithDuration:0.2 animations:^{
        _fogView.alpha = pan / self.bounds.size.width;
    }];
}

@end
