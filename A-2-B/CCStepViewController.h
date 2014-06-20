//
//  CCStepViewController.h
//  A-2-B
//
//  Created by Chad D Colby on 6/18/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRDynamicSlideShow.h"


@protocol StepViewDelegate <NSObject>

- (void)finishedUpdatingStepViews:(BOOL)finished;
- (void)stepsCloseButtonPressed;

@end

@interface CCStepViewController : UIViewController

@property (unsafe_unretained) id <StepViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet DRDynamicSlideShow *slideShow;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray *viewsArray;



- (void)shouldBeginSlideShowSetUp:(BOOL)start;
- (void)clearSlideShowOfSteps;

@end
