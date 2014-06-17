//
//  CCStepByStepViewController.h
//  A-2-B
//
//  Created by Chad D Colby on 6/16/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRDynamicSlideShow.h"

@interface CCStepByStepViewController : UIViewController

@property (weak, nonatomic) IBOutlet DRDynamicSlideShow *stepSlideShow;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end
