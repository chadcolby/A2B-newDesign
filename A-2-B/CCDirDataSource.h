//
//  CCDirDataSource.h
//  A-2-B
//
//  Created by Chad D Colby on 6/4/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCDirDataSource : NSObject

@property (strong, nonatomic) NSArray *dataSourceArray;
@property (strong, nonatomic) id routeDataSoure;
@property (strong, nonatomic) NSMutableArray *stepsDictionariesArray;

+ (CCDirDataSource *)sharedDataSource;
- (void)reloadCollectionViewWithRoute:(id)route;
- (NSArray *)routeDataForStepSlideShow;

@end
