//
//  CCLine.m
//  A-2-B
//
//  Created by Chad D Colby on 6/4/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCLine.h"

@implementation CCLine

- (id)init
{
    self = [super init];
    if (self) {
        self.fineTuneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        self.fineTuneButton.clipsToBounds = YES;
        self.fineTuneButton.layer.cornerRadius = 10.0f;
        self.fineTuneButton.backgroundColor = [UIColor lightGrayColor];
        [self.fineTuneButton addTarget:self action:@selector(fineTuneButtonPressed:) forControlEvents:UIControlEventTouchDown];
        self.canBeMoved = NO;
    }
    
    return self;
}

- (void)updateFineTuneButtonLocation:(CGPoint)location
{
    if (self.fineTuneButton) {
        self.fineTuneButton.center = CGPointMake(location.x, location.y);
    }
}
- (void)dealloc
{
    [self.fineTuneButton removeFromSuperview];
}

- (void)fineTuneButtonPressed:(UIButton *)sender
{
    NSLog(@"%f", self.endPoint.x);
    self.canBeMoved = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"canBeMoved" object:self];

}

@end
