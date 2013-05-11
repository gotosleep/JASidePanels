//
//  MenuCell.m
//
//  Created by Brian McIntyre on 2013-02-10.
//
//

#import "MenuCell.h"

@implementation MenuCell

@synthesize title;

+(NSString *) cellIdentifier{
    return @"MenuCell";
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
	if (self)
	{
	}
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)prepareForReuse
{
    [self setNeedsDisplay];
}

- (void)layoutSubviews
{	
	[super layoutSubviews];
}

@end
