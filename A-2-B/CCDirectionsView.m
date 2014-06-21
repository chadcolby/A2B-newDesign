//
//  CCDirectionsView.m
//  A-2-B
//
//  Created by Chad D Colby on 6/20/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCDirectionsView.h"
#import "AWCollectionViewDialLayout.h"
#import "CCDirDataSource.h"

@interface CCDirectionsView ()

@property (weak, nonatomic) CCDirDataSource *routeDataSource;

@end

@implementation CCDirectionsView

- (id)initWithFrame:(CGRect)frame
{
        AWCollectionViewDialLayout *dialCollectionViewLayout = [[AWCollectionViewDialLayout alloc] initWithRadius:400 andAngularSpacing:20.0f andCellSize:kCELL_SIZE andAlignment:WHEELALIGNMENTCENTER andItemHeight:kCELL_HEIGHT
                                                                                                       andXOffset:200];
    self = [super initWithFrame:frame collectionViewLayout:dialCollectionViewLayout];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.routeDataSource = [CCDirDataSource sharedDataSource];
        self.scrollEnabled = YES;
        self.dataSource = (id)self.routeDataSource;
        self.backgroundColor = [UIColor clearColor];
        [self registerNib:[CCHexCell cellNib] forCellWithReuseIdentifier:kCELL_ID];
    
        [self reloadData];

    }
    return self;
}

@end
