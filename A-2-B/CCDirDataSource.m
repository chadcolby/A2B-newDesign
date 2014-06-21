//
//  CCDirDataSource.m
//  A-2-B
//
//  Created by Chad D Colby on 6/4/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCDirDataSource.h"
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
        return 1;
    } else {
        return self.stepsDictionariesArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CCHexCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCELL_ID forIndexPath:indexPath];
        
    cell.distanceLabel.font = [UIFont fontWithName:@"Prime-Regular" size:17.0f];
    cell.unitLabel.font = [UIFont fontWithName:@"Prime-Regular" size:17.0f];
    cell.instructionsLabel.font = [UIFont fontWithName:@"Prime-Regular" size:15.0f];
    
    cell.distanceLabel.text = [[self convertDistance:[[self.stepsDictionariesArray objectAtIndex:indexPath.item] objectForKey:@"distanceValue"]] objectAtIndex:0];
    cell.unitLabel.text = [[self convertDistance:[[self.stepsDictionariesArray objectAtIndex:indexPath.item] objectForKey:@"distanceValue"]] objectAtIndex:1];
    cell.instructionsLabel.text = [[self.stepsDictionariesArray objectAtIndex:indexPath.item] objectForKey:@"stepInstructions"];
    
    return cell;
}

- (void)reloadCollectionViewWithRoute:(MKRoute *)route  //called by route controller to update collectionView
{
    self.dataSourceArray = [NSArray arrayWithArray:route.steps];
    if (!self.stepsDictionariesArray) {
        self.stepsDictionariesArray = [[NSMutableArray alloc] init];
    } else {
        [self.stepsDictionariesArray removeAllObjects];
    }
    
    for (MKRouteStep *step in self.dataSourceArray) {
        NSString *stringFromDistance = [self convertDistanceToString:step.distance];
        NSDictionary *stepDictionary = [[NSDictionary alloc] initWithObjectsAndKeys: step.instructions, @"stepInstructions", [NSNumber numberWithDouble:step.distance], @"distanceValue", stringFromDistance, @"stringDistance", nil];
        [self.stepsDictionariesArray addObject:stepDictionary];
    }
    
}

#pragma mark - formatting methods

- (NSArray *)convertDistance:(NSNumber *)metersToConvert    //returns appropriate distance values
{
    NSString *convertedString;
    NSString *unitsString;
    
    if ([metersToConvert doubleValue] == 0.0) {
        convertedString = @"Start";
        unitsString = @"";
    } else if ([metersToConvert doubleValue] <= 201.17) {
        CGFloat feetFloat = ([metersToConvert floatValue] * 3.28084);
        convertedString = [NSString stringWithFormat:@"in %.0f", feetFloat];
        unitsString = @"feet";
    } else if ([metersToConvert doubleValue] <= 402.33) {
        convertedString = @"in 1/4";   //quarter mile
        unitsString = @"mile";
    } else if ([metersToConvert doubleValue] <= 531.09) {
        convertedString = @"in 1/3";
        unitsString = @"mile";
    } else if ([metersToConvert doubleValue] <= 804.67) {
        convertedString = @"in 1/2";
        unitsString = @"mile";
    } else if ([metersToConvert doubleValue] <= 1062.62) {
        convertedString = @"in 2/3";
        unitsString = @"mile";
    } else if ([metersToConvert doubleValue] <= 1207.01) {
        convertedString = @"in 3/4";
        unitsString = @"mile";
    }  else if ([metersToConvert doubleValue] <= 1408.18) {
        convertedString = @"in 7/8";
        unitsString = @"mile";
    } else {
        CGFloat mileHolder = ([metersToConvert floatValue] * 0.000621371);
        convertedString = [NSString stringWithFormat:@"in %.2f", mileHolder];
        unitsString = @"miles";
    }
    
    NSArray *convertedDistanceAndUnitsArray = [NSArray arrayWithObjects:convertedString, unitsString, nil];
    return convertedDistanceAndUnitsArray;
}

- (NSString *)convertDistanceToString:(double)doubleMeters    //returns appropriate distance values
{
    NSNumber *metersToConvert = [NSNumber numberWithDouble:doubleMeters];
    NSString *convertedString;

    if ([metersToConvert doubleValue] == 0.0) {
        convertedString = @"Start";
    } else if ([metersToConvert doubleValue] <= 201.17) {
        CGFloat feetFloat = ([metersToConvert floatValue] * 3.28084);
        convertedString = [NSString stringWithFormat:@"in %.0f feet", feetFloat];

    } else if ([metersToConvert doubleValue] <= 402.33) {
        convertedString = @"in 1/4 mile";   //quarter mile

    } else if ([metersToConvert doubleValue] <= 531.09) {
        convertedString = @"in 1/3 mile";

    } else if ([metersToConvert doubleValue] <= 804.67) {
        convertedString = @"in 1/2 mile";

    } else if ([metersToConvert doubleValue] <= 1062.62) {
        convertedString = @"in 2/3 mile";

    } else if ([metersToConvert doubleValue] <= 1207.01) {
        convertedString = @"in 3/4 mile";

    }  else if ([metersToConvert doubleValue] <= 1408.18) {
        convertedString = @"in 7/8 mile";

    } else {
        CGFloat mileHolder = ([metersToConvert floatValue] * 0.000621371);
        convertedString = [NSString stringWithFormat:@"in %.2f mile", mileHolder];
    }
    
    return convertedString;
}

- (NSArray *)routeDataForStepSlideShow
{
    if (self.stepsDictionariesArray) {
        NSArray *routeArray = [NSArray arrayWithArray:self.stepsDictionariesArray];
        return routeArray;
    } else {
        return nil;
    }
    
}

@end
