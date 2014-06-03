//
//  CCDrawingViewController.m
//  A-2-B
//
//  Created by Chad D Colby on 6/2/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCDrawingViewController.h"
#import "CCButtons.h"


@interface CCDrawingViewController ()

@property (weak, nonatomic) IBOutlet CCButtons *backButton;
- (IBAction)backButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet CCButtons *routeButton;
- (IBAction)routeButtonPressed:(id)sender;

@end

@implementation CCDrawingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
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
            NSLog(@"finsished");
            [self.delegate drawingEventCancelled];
        }
    }];
}

- (IBAction)routeButtonPressed:(id)sender
{
    
}


@end
