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

@end
