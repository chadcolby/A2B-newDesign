//
//  CCHexCell.m
//  A-2-B
//
//  Created by Chad D Colby on 6/3/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCHexCell.h"

@implementation CCHexCell

static UINib *cellNib;

+ (UINib *)cellNib
{
    if (cellNib) {
        return cellNib;
    }
    
    cellNib = [UINib nibWithNibName:kCELL_XIB bundle:nil];
    
    return cellNib;
}

//- (void)setImage:(UIImage *)image
//{
//    // Store image
//    //    self.MJImageView.image = image;
//    
//    // Update padding
//    [self setImageOffset:self.labelOffset];
//}

- (void)setLabelOffset:(CGPoint)labelOffset
{
    // Store padding value
    _labelOffset = labelOffset;
    
    // Grow image view
    CGRect distFrame = self.distanceLabel.bounds;
    CGRect distOffsetFrame = CGRectOffset(distFrame, _labelOffset.x, _labelOffset.y);
    self.distanceLabel.frame = distOffsetFrame;
    
    CGRect unitFrame = self.unitLabel.bounds;
    CGRect unitOffsetFrame = CGRectOffset(unitFrame, _labelOffset.x + 5, 31);
    self.unitLabel.frame = unitOffsetFrame;
    
    CGRect instructionsFrame = self.instructionsLabel.bounds;
    CGRect instructionsOffsetFrame = CGRectOffset(instructionsFrame, _labelOffset.x - 18, 43);
    self.instructionsLabel.frame = instructionsOffsetFrame;

    
}

@end
