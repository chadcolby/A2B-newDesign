//
//  CCDirecitonsListViewController.m
//  A-2-B
//
//  Created by Chad D Colby on 6/20/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCDirecitonsListViewController.h"


@interface CCDirecitonsListViewController ()



@end

@implementation CCDirecitonsListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"loaded");
    self.navigationController.navigationBarHidden = NO;
    self.collectionView = [[CCHexCollectionView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + 50, self.view.bounds.size.width, self.view.bounds.size.height - 50)];
    [self.collectionView reloadData];
    [self.view addSubview:self.collectionView];
    self.collectionView.layer.shadowOffset = CGSizeMake(10.f, 10.f);
    self.collectionView.layer.shadowRadius = 5.0f;
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

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
