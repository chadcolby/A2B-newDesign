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

- (id)initWIthEstimatedTime:(NSString *)estimatedTime andDistance:(NSString *)distance andFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10.0f;
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.6f;
        self.estimatedTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height / 2)];
        self.estimatedTimeLabel.numberOfLines = 2.0;
        self.estimatedTimeLabel.text = estimatedTime;
        self.estimatedTimeLabel.font = [UIFont fontWithName:@"Prime-Regular" size:13.f];
        self.estimatedTimeLabel.textAlignment = NSTextAlignmentCenter;
        self.estimatedTimeLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.estimatedTimeLabel];
        self.totalDistanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.size.height / 2, self.bounds.size.width, self.bounds.size.height / 2)];
        self.totalDistanceLabel.text = distance;
        self.totalDistanceLabel.font = [UIFont fontWithName:@"Prime-Regular" size:13.f];
        self.totalDistanceLabel.textAlignment = NSTextAlignmentCenter;
        self.totalDistanceLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.totalDistanceLabel];
    }
    return self;
}

- (id)initForAddressView:(NSString *)address AndFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10.0f;
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.6f;
        self.estimatedTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height)];
        self.estimatedTimeLabel.numberOfLines = 2.0;
        self.estimatedTimeLabel.text = address;
        self.estimatedTimeLabel.font = [UIFont fontWithName:@"Prime-Regular" size:15.f];
        self.estimatedTimeLabel.textAlignment = NSTextAlignmentCenter;
        self.estimatedTimeLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.estimatedTimeLabel];
        
        UITapGestureRecognizer *tapToClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToClose:)];
        tapToClose.numberOfTapsRequired = 1;
        tapToClose.numberOfTouchesRequired = 1;
        
        [self addGestureRecognizer:tapToClose];
        
    }
    return self;
}

- (void)tapToClose:(UITapGestureRecognizer *)sender
{
    [self removeFromSuperview];

}


@end
