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

@property (strong, nonatomic) NSMutableArray *stepsDictionariesArray;

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
        return 1;
    } else {
        return self.stepsDictionariesArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CCHexCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCELL_ID forIndexPath:indexPath];
    cell.distanceLabel.text = [NSString stringWithFormat:@"%@", [[self.stepsDictionariesArray objectAtIndex:indexPath.row] objectForKey:@"distanceValue"]];
    return cell;
}

- (void)reloadCollectionViewWithRoute:(MKRoute *)route
{
    self.dataSourceArray = [NSArray arrayWithArray:route.steps];
    if (!self.stepsDictionariesArray) {
        self.stepsDictionariesArray = [[NSMutableArray alloc] init];
    } else {
        [self.stepsDictionariesArray removeAllObjects];
    }
    
    for (MKRouteStep *step in self.dataSourceArray) {
        NSLog(@">>>> %@", step.instructions);
        NSDictionary *stepDictionary = [[NSDictionary alloc] initWithObjectsAndKeys: step.instructions, @"directionStep", [NSNumber numberWithDouble:step.distance], @"distanceValue", nil];
        [self.stepsDictionariesArray addObject:stepDictionary];
    }
    
    NSLog(@"END: %@", self.stepsDictionariesArray);
}

@end
