//
//  CCDirectionsViewController.m
//  A-2-B
//
//  Created by Chad D Colby on 6/2/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCDirectionsViewController.h"
#import "CCHexagonFlowLayout.h"
#import "CCHexCell.h"

@interface CCDirectionsViewController () <UICollectionViewDataSource, UICollectionViewDelegate>



@end

@implementation CCDirectionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self directionsCollectionViewSetUp];
    NSLog(@"%@", self.superclass);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)directionsCollectionViewSetUp
{
    CCHexagonFlowLayout *collectionViewLayout = [[CCHexagonFlowLayout alloc] init];
    collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionViewLayout.minimumInteritemSpacing = -30.0f;
    collectionViewLayout.minimumLineSpacing = 10.0f;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20.0f, 15.0f, 20.0f, 15.0f);
    collectionViewLayout.itemSize = kCELL_SIZE;
    collectionViewLayout.gap = 76.0f;
    
    self.collectionView = [[CCHexCollectionView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 222,
                                                                             CGRectGetWidth(self.view.frame), 222)
                                             collectionViewLayout:collectionViewLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[CCHexCell cellNib] forCellWithReuseIdentifier:kCELL_ID];

    [self.view addSubview:self.collectionView];
    
    [self.collectionView reloadData];
    
    NSLog(@"reloaded");
}

#pragma mark - CollectionView Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CCHexCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCELL_ID forIndexPath:indexPath];
    
    
    return cell;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches");

}

@end
