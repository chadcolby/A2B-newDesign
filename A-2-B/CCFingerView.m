//
//  CCFingerView.m
//  A-2-B
//
//  Created by Chad D Colby on 6/21/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCFingerView.h"


@interface CCFingerView ()

@end

@implementation CCFingerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = self.frame.size.height / 2;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        
        self.mapView = [[MKMapView alloc] initWithFrame:self.frame];
        [self addSubview:self.mapView];
        
        UIView *targetView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2 - 17, self.bounds.size.height / 2 - 17, 34, 34)];
        
        targetView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pinPoint"]];
        [self addSubview:targetView];
        
    }
    return self;
}

@end
