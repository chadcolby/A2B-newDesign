//
//  CCButtons.m
//  A-2-B
//
//  Created by Chad D Colby on 6/2/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCButtons.h"


@implementation CCButtons

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
//        self.clipsToBounds = YES;
//        self.layer.cornerRadius = 25.0f;
//        self.layer.borderColor = [[UIColor colorWithRed:112.f/255 green:128.f/255 blue:144.f/255 alpha:1.0f] CGColor];
//        self.layer.borderWidth = 1.0;
        self.showsTouchWhenHighlighted = YES;

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    
    return self;
}

- (id)initForScrollButtonWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 25.0f;
        self.layer.borderColor = [[UIColor colorWithRed:112.f/255 green:128.f/255 blue:144.f/255 alpha:1.0f] CGColor];
        self.layer.borderWidth = 1.0;
        self.backgroundColor = [UIColor lightGrayColor];
    }
    
    return self;
    
}

@end
