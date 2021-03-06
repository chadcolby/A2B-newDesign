//
//  CCMenuView.m
//  A-2-B
//
//  Created by Chad D Colby on 6/3/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCMenuView.h"

@implementation CCMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.8f;
        [self buttonsSetUp];

    }
    return self;
}

- (void)buttonsSetUp
{
    self.directionsButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.origin.x + 17.5, 25, 50, 50)];
    [self.directionsButton setImage:[UIImage imageNamed:@"directions"] forState:UIControlStateNormal];
    [self addSubview:self.directionsButton];
    

    self.forwardButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.origin.x + 135, 25, 50, 50)];
    [self.forwardButton setImage:[UIImage imageNamed:@"send"] forState:UIControlStateNormal];
    [self addSubview:self.forwardButton];
    
    self.clearButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.origin.x + 252.5, 25, 50, 50)];
    [self.clearButton setImage:[UIImage imageNamed:@"trash"] forState:UIControlStateNormal];
    [self addSubview:self.clearButton];
    
}

@end
