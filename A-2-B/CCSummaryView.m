//
//  CCSummaryView.m
//  A-2-B
//
//  Created by Chad D Colby on 6/11/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCSummaryView.h"

@implementation CCSummaryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWIthEstimatedTime:(NSNumber *)estimatedTime andDistance:(NSNumber *)distance andFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10.0f;
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.4f;
        self.estimatedTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height / 2)];
        self.estimatedTimeLabel.text = [NSString stringWithFormat:@"%@", estimatedTime];
        self.estimatedTimeLabel.font = [UIFont fontWithName:@"Prime-Regular" size:10.f];
        self.estimatedTimeLabel.textAlignment = NSTextAlignmentCenter;
        self.estimatedTimeLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.estimatedTimeLabel];
        self.totalDistanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.size.height / 2, self.bounds.size.width, self.bounds.size.height / 2)];
        self.totalDistanceLabel.text = [NSString stringWithFormat:@"%@", distance];
        self.totalDistanceLabel.font = [UIFont fontWithName:@"Prime-Regular" size:10.f];
        self.totalDistanceLabel.textAlignment = NSTextAlignmentCenter;
        self.totalDistanceLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.totalDistanceLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
