//
//  CCStepLabel.m
//  A-2-B
//
//  Created by Chad D Colby on 6/18/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCStepLabel.h"
#import "CCConstants.h"

@implementation CCStepLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10.0f;
        self.textColor = [UIColor whiteColor];
        self.alpha = 0.5f;
        self.numberOfLines = 3;
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont fontWithName:kPRIME_TEXT size:15.0f];
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
