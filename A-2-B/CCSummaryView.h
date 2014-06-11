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

- (id)initWIthEstimatedTime:(NSNumber *)estimatedTime andDistance:(NSNumber *)distance andFrame:(CGRect)frame;

@end
