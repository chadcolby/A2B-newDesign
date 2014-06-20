//
//  CCStepViewController.m
//  A-2-B
//
//  Created by Chad D Colby on 6/18/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCStepViewController.h"
#import "CCStepView.h"
#import "CCDirDataSource.h"
#import "CINBouncyButton.h"

@interface CCStepViewController ()

@property (strong, nonatomic) NSArray *routeArray;
@property (strong, nonatomic) CINBouncyButton *stepsCloseButton;
@property (strong, nonatomic) CINBouncyButton *completeDirectionsButton;

@end

@implementation CCStepViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.completeDirectionsButton = [[CINBouncyButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 70, 20,50, 50) image:[UIImage imageNamed:@"menu"] andTitle:nil forMenu:NO];
    [self.completeDirectionsButton addTarget:self action:@selector(completeDirectionsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.completeDirectionsButton];
    
    self.stepsCloseButton = [[CINBouncyButton alloc] initWithFrame:CGRectMake(20, 20, 50, 50) image:[UIImage imageNamed:@"close"] andTitle:nil forMenu:NO];
    [self.stepsCloseButton addTarget:self action:@selector(stepsCloseButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.stepsCloseButton];
    
    self.view.backgroundColor = [UIColor clearColor];
    [self.slideShow setDidReachPageBlock:^(NSInteger reachedPage) {
        self.pageControl.currentPage = reachedPage;
    }];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}




- (void)shouldBeginSlideShowSetUp:(BOOL)start
{
    if (start) {
        self.routeArray = [[CCDirDataSource sharedDataSource] routeDataForStepSlideShow];
        [self.slideShow setContentSize:CGSizeMake(320.0f * self.routeArray.count, self.view.bounds.size.height)];
        [self slideShowSetUp];
        
    }
}

- (void)slideShowSetUp
{
    self.viewsArray = [[NSMutableArray alloc] initWithCapacity:self.routeArray.count];
    
    self.pageControl.numberOfPages = self.viewsArray.count;
    
        for (NSInteger j = 0; j < self.routeArray.count; j++) {
            NSString *distString = [[self.routeArray objectAtIndex:j] objectForKey:@"stringDistance"];
            NSString *instructString = [[self.routeArray objectAtIndex:j] objectForKey:@"stepInstructions"];
            NSLog(@"in %@ %@", distString, instructString);
            CCStepView *stepView = [[CCStepView alloc] initWithFrame:self.view.bounds AndDistance:distString AndInstructions:instructString];
            [self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:stepView.distanceLabel page:j keyPath:@"center" toValue:[NSValue valueWithCGPoint:CGPointMake(stepView.distanceLabel.center.x+self.slideShow.frame.size.width, stepView.distanceLabel.center.y-self.slideShow.frame.size.height)] delay:0]];
            
            [self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:stepView.instructionLabel page:j keyPath:@"center" toValue:[NSValue valueWithCGPoint:CGPointMake(stepView.instructionLabel.center.x+self.slideShow.frame.size.width, stepView.instructionLabel.center.y+self.slideShow.frame.size.height)] delay:0]];


            [self.viewsArray addObject:stepView];
            if (self.viewsArray.count == self.routeArray.count) {
                [self performSelector:@selector(updateSlideShow) withObject:nil];
            }
        }
}

- (void)updateSlideShow
{
    NSInteger counter = 0;
    for (CCStepView *step in self.viewsArray) {
        [self.slideShow addSubview:step onPage:counter];
        counter ++;
    }
    [self.view bringSubviewToFront:self.stepsCloseButton];
    [self.delegate finishedUpdatingStepViews:YES];
}

- (void)clearSlideShowOfSteps
{
    for (CCStepView *stepView in self.viewsArray) {
        [stepView removeFromSuperview];
    }
}

#pragma mark - Button Actions

- (void)stepsCloseButtonPressed:(id)sender
{
    [self.delegate stepsCloseButtonPressed];
}

- (void)completeDirectionsButtonPressed:(id)sender
{
    NSLog(@"list");
    [self performSegueWithIdentifier:@"pushToList" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pushToList"]) {
        NSLog(@"pushing");
    }
}
@end
