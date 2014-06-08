//
//  CCMenuView.h
//  A-2-B
//
//  Created by Chad D Colby on 6/3/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCButtons.h"

@interface CCMenuView : UIView

@property (strong, nonatomic) CCButtons *directionsButton;
@property (strong, nonatomic) CCButtons *forwardButton;
@property (strong, nonatomic) CCButtons *clearButton;
@property (strong, nonatomic) CCButtons *settingsButton;

@property (strong, nonatomic) NSArray *directionsArray;

@end
