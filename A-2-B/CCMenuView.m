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
    self.directionsButton = [[CCButtons alloc] initWithFrame:CGRectMake(self.bounds.origin.x + 15, 25, 50, 50)];
    [self.directionsButton setImage:[UIImage imageNamed:@"directions"] forState:UIControlStateNormal];
    self.directionsButton.enabled = NO;
    [self addSubview:self.directionsButton];
    
    self.forwardButton = [[CCButtons alloc] initWithFrame:CGRectMake(self.bounds.origin.x + 95, 25, 50, 50)];
    [self.forwardButton setImage:[UIImage imageNamed:@"send"] forState:UIControlStateNormal];
    [self addSubview:self.forwardButton];
    
    self.clearButton = [[CCButtons alloc] initWithFrame:CGRectMake(self.bounds.origin.x + 175, 25, 50, 50)];
    [self.clearButton setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
    self.clearButton.enabled = NO;
    [self addSubview:self.clearButton];
    
    self.settingsButton = [[CCButtons alloc] initWithFrame:CGRectMake(self.bounds.origin.x + 255, 25, 50, 50)];
    [self.settingsButton setImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
    [self addSubview:self.settingsButton];
}

@end
