//
//  CCStepView.h
//  A-2-B
//
//  Created by Chad D Colby on 6/18/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCStepLabel.h"

@interface CCStepView : UIView

@property (strong, nonatomic) CCStepLabel *distanceLabel;
@property (strong, nonatomic) CCStepLabel *instructionLabel;

- (id)initWithFrame:(CGRect)frame AndDistance:(NSString *)distance AndInstructions:(NSString *)instructions;

@end
