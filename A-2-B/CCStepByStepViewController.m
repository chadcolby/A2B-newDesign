//
//  CCStepByStepViewController.m
//  A-2-B
//
//  Created by Chad D Colby on 6/16/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCStepByStepViewController.h"
#import "CCStepView.h"
#import "CCDirDataSource.h"

@interface CCStepByStepViewController ()

@property (strong, nonatomic) NSArray *distancesArray;
@property (strong, nonatomic) NSArray *instructionsArray;

@end

@implementation CCStepByStepViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self slideShowSetUp];
    
    NSArray *someArray = [[CCDirDataSource sharedDataSource] routeDataForStepSlideShow];
    NSLog(@"%@", someArray);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)slideShowSetUp
{
    self.stepSlideShow.backgroundColor = [UIColor clearColor];
    self.instructionsArray = [NSArray arrayWithObjects:@"Turn left", @"Turn Right", @"Go Straight", @"End at Destination", nil];
    self.distancesArray = [NSArray arrayWithObjects:@"3 miles", @"500 feet", @"1/4 mile", @"10 miles", nil];
    
    [self.stepSlideShow setContentSize:CGSizeMake(320.0f * self.distancesArray.count, self.view.bounds.size.height)];
    [self.stepSlideShow setDidReachPageBlock:^(NSInteger reachedPage) {
        self.pageControl.currentPage = reachedPage;
    }];
    
    self.pageControl.numberOfPages = self.distancesArray.count;
    
    for (NSInteger i = 0; i < self.distancesArray.count; i++) {
        CCStepView *stepView = [[CCStepView alloc] initWithFrame:self.view.bounds AndDistance:[self.distancesArray objectAtIndex:i] AndInstructions:[self.instructionsArray objectAtIndex:i]];
        
        [self.stepSlideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:stepView.distanceLabel page:i keyPath:@"center" toValue:[NSValue valueWithCGPoint:CGPointMake(stepView.distanceLabel.center.x+self.stepSlideShow.frame.size.width, stepView.distanceLabel.center.y-self.stepSlideShow.frame.size.height)] delay:0]];
        
        [self.stepSlideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:stepView.instructionLabel page:i keyPath:@"center" toValue:[NSValue valueWithCGPoint:CGPointMake(stepView.instructionLabel.center.x+self.stepSlideShow.frame.size.width, stepView.instructionLabel.center.y-self.stepSlideShow.frame.size.height)] delay:0]];
        [self.stepSlideShow addSubview:stepView onPage:i];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
