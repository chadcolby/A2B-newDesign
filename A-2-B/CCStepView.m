//
//  CCStepView.m
//  A-2-B
//
//  Created by Chad D Colby on 6/18/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCStepView.h"

@implementation CCStepView

- (id)initWithFrame:(CGRect)frame AndDistance:(NSString *)distance AndInstructions:(NSString *)instructions
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.distanceLabel = [[CCStepLabel alloc] initWithFrame:CGRectMake(100, 30, 120, 30)];
        self.instructionLabel = [[CCStepLabel alloc] initWithFrame:CGRectMake(20, self.bounds.size.height - 130, 280, 100)];
        
        self.distanceLabel.text = distance;
        self.instructionLabel.text = instructions;
        
        [self addSubview:self.distanceLabel];
        [self addSubview:self.instructionLabel];
        
    }
    return self;
}

@end
