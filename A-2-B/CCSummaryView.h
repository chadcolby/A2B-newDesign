//
//  CCSummaryView.h
//  A-2-B
//
//  Created by Chad D Colby on 6/11/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCSummaryView : UIView

@property (strong, nonatomic) UILabel *estimatedTimeLabel;
@property (strong, nonatomic) UILabel *totalDistanceLabel;

- (id)initWIthEstimatedTime:(NSString *)estimatedTime andDistance:(NSString *)distance andFrame:(CGRect)frame;
- (id)initForAddressView:(NSString *)address AndFrame:(CGRect)frame;

@end
