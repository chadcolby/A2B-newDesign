//
//  CCDirDataSource.m
//  A-2-B
//
//  Created by Chad D Colby on 6/4/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCDirDataSource.h"
#import "CCHexCell.h"
#import "CCRouteRequestController.h"
#import <MapKit/MapKit.h>

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
    if (!self.dataSourceArray) {
        return 0;
    } else {
        return self.dataSourceArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CCHexCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCELL_ID forIndexPath:indexPath];
    
    return cell;
}

- (void)reloadCollectionViewWithRoute:(MKRoute *)route
{
    self.dataSourceArray = [NSArray arrayWithArray:route.steps];
    for (MKRouteStep *step in self.dataSourceArray) {
        NSLog(@">>>> %@", step.instructions);
    }
}

@end
