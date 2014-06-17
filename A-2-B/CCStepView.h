//
//  CCStepView.h
//  A-2-B
//
//  Created by Chad D Colby on 6/16/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCStepView : UIView

@property (strong, nonatomic) UILabel *distanceLabel;
@property (strong, nonatomic) UILabel *instructionLabel;

- (id)initWithFrame:(CGRect)frame AndDistance:(NSString *)distance AndInstructions:(NSString *)instructions;

@end
