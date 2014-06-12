//
//  CCDrawingViewController.m
//  A-2-B
//
//  Created by Chad D Colby on 6/2/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCDrawingViewController.h"
#import "CCButtons.h"


@interface CCDrawingViewController () <DrawingEventDelegate>

@property (strong, nonatomic) CCDrawingView *drawingView;
@property (strong, nonatomic) CCLine *requstedRoute;

@property (weak, nonatomic) IBOutlet CCButtons *backButton;
- (IBAction)backButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet CCButtons *routeButton;
- (IBAction)routeButtonPressed:(id)sender;

@end

@implementation CCDrawingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.drawingView = (CCDrawingView *)self.view;
    self.drawingView.delegate = self;
    self.routeButton.enabled = NO;  //enabled once a line is finished
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark - IBActions

- (IBAction)backButtonPressed:(id)sender
{
    [UIView animateWithDuration:0.2 animations:^{
        self.view.hidden = YES;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.delegate drawingEventCancelled];
            [self.drawingView clearLines];
        }
    }];
}

- (IBAction)routeButtonPressed:(id)sender
{
    if (self.requstedRoute) {
        [UIView animateWithDuration:0.4 animations:^{
            self.view.hidden = YES;
        } completion:^(BOOL finished) {
            if (finished) {
                [self.delegate requestRouteFromLine:self.requstedRoute];    //mapView translates line points into own coordinate system
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

@end
