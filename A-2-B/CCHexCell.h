//
//  CCHexCell.h
//  A-2-B
//
//  Created by Chad D Colby on 6/3/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCELL_ID    @"dirCell_ID"
#define kCELL_XIB   @"CCHexCell"
#define kCELL_SIZE  CGSizeMake(280, 145)
#define kCELL_HEIGHT 145
#define kCELL_WIDTH 280
#define kLABEL_OFFSET_SPEED 25

@interface CCHexCell : UICollectionViewCell

@property (assign, nonatomic) IBOutlet UILabel *distanceLabel;
@property (assign, nonatomic) IBOutlet UILabel *unitLabel;
@property (assign, nonatomic) IBOutlet UILabel *instructionsLabel;

@property (nonatomic, assign, readwrite) CGPoint labelOffset;

+ (UINib *)cellNib;

@end
