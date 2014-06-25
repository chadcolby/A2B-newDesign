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

- (id)initForInstructionLabel
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(20, 10, 280, 30);
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10.0f;
        self.textColor = [UIColor whiteColor];
        self.alpha = 1.0f;
        self.backgroundColor = [UIColor colorWithRed:185.f/255 green:61.f/255 blue:76.f/255 alpha:1.0f];
        self.numberOfLines = 1;
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont fontWithName:kPRIME_TEXT size:15.0f];
        
    }
    return self;
}

@end
