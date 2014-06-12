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
#import "CCButtons.h"

@interface CCHexCollectionView ()

@end

@implementation CCHexCollectionView

- (id)initWithFrame:(CGRect)frame
{
    CCHexagonFlowLayout *collectionViewLayout = [[CCHexagonFlowLayout alloc] init];
    collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    collectionViewLayout.minimumInteritemSpacing = -30.0f;
    collectionViewLayout.minimumInteritemSpacing = 0.0f;
    collectionViewLayout.minimumLineSpacing = 10.0f;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20.0f, 15.0f, 20.0f, 15.0f);
    collectionViewLayout.itemSize = kCELL_SIZE;
    collectionViewLayout.gap = 76.0f;
    
    self = [super initWithFrame:frame collectionViewLayout:collectionViewLayout];
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

- (void)scrollToFront:(CCButtons *)sender
{
    [self scrollRectToVisible:CGRectMake(0, 0, 320, 222) animated:YES];
}

@end
