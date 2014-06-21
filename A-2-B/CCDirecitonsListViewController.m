//
//  CCDirecitonsListViewController.m
//  A-2-B
//
//  Created by Chad D Colby on 6/20/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCDirecitonsListViewController.h"
#import "CINBouncyButton.h"

@interface CCDirecitonsListViewController ()

@property (strong, nonatomic) CINBouncyButton *closeButton;

@end

@implementation CCDirecitonsListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"dirs");
    
    self.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBarHidden = NO;
    self.view.alpha = 0.0f;
    self.directionCollectionView = [[CCDirectionsView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + 50, self.view.bounds.size.width, self.view.bounds.size.height - 50)];
    [self.directionCollectionView reloadData];
    [self.view addSubview:self.directionCollectionView];
    
    self.closeButton = [[CINBouncyButton alloc] initWithFrame:CGRectMake(20, 20, 50, 50) image:[UIImage imageNamed:@"close"] andTitle:nil forMenu:NO];
    [self.closeButton addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)showDirections
{
    [UIView animateWithDuration:0.4 animations:^{
        self.view.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)closeButtonPressed:(CINBouncyButton *)sender
{
    [UIView animateWithDuration:0.4f animations:^{
        self.view.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        [self.delegate directionsViewClosed];
    }];
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
