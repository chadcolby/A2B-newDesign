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

@property (strong, nonatomic) NSMutableArray *distancesArray;
@property (strong, nonatomic) NSMutableArray *instructionsArray;
@property (strong, nonatomic) NSArray *routeArray;

@property (strong, nonatomic) NSMutableArray *viewsArray;

@end

@implementation CCStepByStepViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.routeArray = [[CCDirDataSource sharedDataSource] routeDataForStepSlideShow];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSlideShow:) name:@"stepByStepComplete" object:nil];
    if (self.routeArray != nil) {
        [self slideShowSetUp];
        NSLog(@"RUNNING");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)slideShowSetUp
{
    self.routeArray = [[CCDirDataSource sharedDataSource] routeDataForStepSlideShow];
    self.viewsArray = [[NSMutableArray alloc] initWithCapacity:self.routeArray.count];
    
    [self.stepSlideShow setContentSize:CGSizeMake(320.0f * self.routeArray.count, self.view.bounds.size.height)];
    [self.stepSlideShow setDidReachPageBlock:^(NSInteger reachedPage) {
        self.pageControl.currentPage = reachedPage;
        NSLog(@"%ld", (long)reachedPage);
    }];
    
    self.pageControl.numberOfPages = self.distancesArray.count;

    self.distancesArray = [[NSMutableArray alloc] init];
    self.instructionsArray = [[NSMutableArray alloc] init];
    
    NSOperationQueue *someQueue = [[NSOperationQueue alloc] init];
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        for (NSInteger i = 0; i < 100; i++) {
            NSLog(@"%lu", i);
        }
    }];
    [operation setCompletionBlock:^{
        NSLog(@"all done");
    }];
    
    [someQueue addOperation:operation];
//        for (NSInteger j = 0; j < self.routeArray.count; j++) {
//                NSString *distString = [[self.routeArray objectAtIndex:j] objectForKey:@"stringDistance"];
//                NSString *instructString = [[self.routeArray objectAtIndex:j] objectForKey:@"stepInstructions"];
//                NSLog(@"in %@ %@", distString, instructString);
//                CCStepView *stepView = [[CCStepView alloc] initWithFrame:self.view.bounds AndDistance:distString AndInstructions:instructString];
//                [self.stepSlideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:stepView.distanceLabel page:j keyPath:@"center" toValue:[NSValue valueWithCGPoint:CGPointMake(stepView.distanceLabel.center.x+self.stepSlideShow.frame.size.width, stepView.distanceLabel.center.y-self.stepSlideShow.frame.size.height)] delay:0]];
//                
//                [self.stepSlideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:stepView.instructionLabel page:j keyPath:@"center" toValue:[NSValue valueWithCGPoint:CGPointMake(stepView.instructionLabel.center.x+self.stepSlideShow.frame.size.width, stepView.instructionLabel.center.y-self.stepSlideShow.frame.size.height)] delay:0]];
//                [self.viewsArray addObject:stepView];
//
//                [self.stepSlideShow addSubview:stepView onPage:j];
//        }
}

- (void)updateSlideShow:(NSNotification *)notification
{
    NSArray *views = [notification.userInfo objectForKey:@"viewsArray"];
    NSLog(@">>>>>> %@", views);
    NSInteger counter = 0;
    for (CCStepView *step in views) {
        NSLog(@"%lu", counter);
        [self.stepSlideShow addSubview:step onPage:counter];
        counter ++;
    }
//    [self.delegate subViewsCreated];

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
