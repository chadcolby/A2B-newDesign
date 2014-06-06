//
//  CCBackView.m
//  A-2-B
//
//  Created by Chad D Colby on 6/5/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCBackView.h"

@implementation CCBackView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5f;
        self.exclusiveTouch = NO;
        self.userInteractionEnabled = NO;
        NSLog(@"back view");
    }
    return self;
}


@end
