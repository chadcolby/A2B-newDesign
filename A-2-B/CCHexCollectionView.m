//
//  CCHexCollectionView.m
//  A-2-B
//
//  Created by Chad D Colby on 6/3/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCHexCollectionView.h"
#import "CCHexagonFlowLayout.h"
#import "CCHexCell.h"
#import "CCFadeLayout.h"
#import "AWCollectionViewDialLayout.h"


@interface CCHexCollectionView () 

@end

@implementation CCHexCollectionView

- (id)initWithFrame:(CGRect)frame
{
    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    flowLayout.minimumInteritemSpacing = 10.0f;
//    flowLayout.minimumLineSpacing = 10.0f;
//    flowLayout.sectionInset = UIEdgeInsetsMake(80, 20, 10, 20);
//    flowLayout.itemSize = kCELL_SIZE;
//    CCFadeLayout *fadeLayout = [[CCFadeLayout alloc] init];

    AWCollectionViewDialLayout *dialCollectionViewLayout = [[AWCollectionViewDialLayout alloc] initWithRadius:400 andAngularSpacing:20.0f andCellSize:kCELL_SIZE andAlignment:WHEELALIGNMENTCENTER andItemHeight:kCELL_HEIGHT andXOffset:200];
    
    self = [super initWithFrame:frame collectionViewLayout:dialCollectionViewLayout];
    if (self) {

        self.routeDataSource = [CCDirDataSource sharedDataSource];
        self.scrollEnabled = YES;
        self.dataSource = (id)self.routeDataSource;
        self.backgroundColor = [UIColor clearColor];
        [self registerNib:[CCHexCell cellNib] forCellWithReuseIdentifier:kCELL_ID];

        UITapGestureRecognizer *tapToScroll = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollToFront:)];
        tapToScroll.numberOfTapsRequired = 2;
        tapToScroll.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tapToScroll];
        [self reloadData];

    }
    return self;
}



- (void)scrollToFront:(id)sender
{
    [self scrollRectToVisible:CGRectMake(0, 0, 320, 222) animated:YES];
}

@end
