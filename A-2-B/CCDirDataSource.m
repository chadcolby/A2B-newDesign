//
//  CCDirDataSource.m
//  A-2-B
//
//  Created by Chad D Colby on 6/4/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCDirDataSource.h"
#import "CCHexCell.h"

@interface CCDirDataSource () <UICollectionViewDataSource>



@end

@implementation CCDirDataSource

+ (CCDirDataSource *)sharedDataSource
{
    static dispatch_once_t pred;
    static CCDirDataSource *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[CCDirDataSource alloc] init];
    });
    
    return shared;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return self.dataSourceArray.count;
    return  3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CCHexCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCELL_ID forIndexPath:indexPath];
    
    return cell;
}

@end
