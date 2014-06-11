//
//  CCHexCollectionView.h
//  A-2-B
//
//  Created by Chad D Colby on 6/3/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCDirDataSource.h"

@interface CCHexCollectionView : UICollectionView

@property (strong, nonatomic) CCDirDataSource *routeDataSource;

@end
