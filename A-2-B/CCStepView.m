//
//  CCStepView.m
//  A-2-B
//
//  Created by Chad D Colby on 6/16/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCStepView.h"

@implementation CCStepView

- (id)initWithFrame:(CGRect)frame AndDistance:(NSString *)distance AndInstructions:(NSString *)instructions
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 280, 30)];
        self.instructionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 280, 100)];
        self.instructionLabel.numberOfLines = 3;
        self.distanceLabel.textColor = [UIColor redColor];
        self.instructionLabel.textColor = [UIColor redColor];
        
        self.distanceLabel.text = distance;
        self.instructionLabel.text = instructions;
        
        [self addSubview:self.distanceLabel];
        [self addSubview:self.instructionLabel];

    }
    return self;
}

@end
