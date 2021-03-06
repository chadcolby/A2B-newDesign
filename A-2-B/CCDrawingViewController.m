//
//  CCDrawingViewController.m
//  A-2-B
//
//  Created by Chad D Colby on 6/2/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCDrawingViewController.h"

@interface CCDrawingViewController () <DrawingEventDelegate>

@property (strong, nonatomic) CCLine *requstedRoute;

@property (strong, nonatomic) CINBouncyButton *routeButton;
@property (strong, nonatomic) CINBouncyButton *backButton;

@end

@implementation CCDrawingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.drawingView = (CCDrawingView *)self.view;
    self.drawingView.delegate = self;
    self.routeButton.enabled = NO;  //enabled once a line is finished
    
    self.backButton = [[CINBouncyButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 70, self.view.bounds.size.height - 70, 50, 50) image:[UIImage imageNamed:@"back"] andTitle:nil forMenu:NO];
    [self.backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    self.routeButton = [[CINBouncyButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 + 20, self.view.bounds.size.height - 70, 50, 50) image:[UIImage imageNamed:@"check"] andTitle:nil forMenu:NO];
    [self.routeButton addTarget:self action:@selector(routeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.routeButton];
    
    self.instructionsLabel = [[CCStepLabel alloc] initForInstructionLabel];
    self.instructionsLabel.text = @"Draw Your Desired Route";
    self.instructionsLabel.alpha = 0.0f;
    [self.view addSubview:self.instructionsLabel];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self animationInstructionsLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)animationInstructionsLabel
{
    [UIView animateWithDuration:0.4 animations:^{
        self.instructionsLabel.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - IBActions

- (void)backButtonPressed:(id)sender
{
        [UIView animateWithDuration:0.2f animations:^{
            self.view.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self.delegate drawingEventCancelled];
            [self.drawingView clearLines];
        }];
}

- (void)routeButtonPressed:(id)sender
{
    if (self.requstedRoute) {
        [UIView animateWithDuration:0.4 animations:^{
            self.view.alpha = 0.0f;

        } completion:^(BOOL finished) {
            if (finished) {
                [self.delegate requestRouteFromLine:self.requstedRoute];    //mapView translates line points into own coordinate system
                self.view.hidden = YES;
                [self.drawingView clearLines];
            }
        }];
    }
    
}

#pragma mark - DrawingEventDelegate

- (void)drawingEventFinishedWithLine:(CCLine *)finishedLine //drawing view informs self that line finished
{
    if (finishedLine) {
        self.requstedRoute = finishedLine;
    } else {
        self.requstedRoute = nil;
    }
}

- (void)routeRequestEnabled:(BOOL)enabled
{
    if (enabled) {
        self.routeButton.enabled = YES;
    }
}

- (void)fingerViewCenterForCurrentLine:(CCLine *)currentLine
{
    [self.delegate updateFingerMapViewFromMainMap:currentLine];
}

@end
