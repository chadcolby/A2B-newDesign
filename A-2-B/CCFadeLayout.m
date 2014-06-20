//
//  CCFadeLayout.m
//  A-2-B
//
//  Created by Chad D Colby on 6/20/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCFadeLayout.h"
#import "CCHexCell.h"

@implementation CCFadeLayout

- (void)prepareLayout
{
    self.itemSize = kCELL_SIZE;
    self.minimumLineSpacing = 10.0f;
    self.minimumInteritemSpacing = 10.0f;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sectionInset = UIEdgeInsetsMake(80, 20, 10, 20);
    
}

//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
//    CGRect visibleRect;
//    visibleRect.origin = self.collectionView.contentOffset;
//    visibleRect.size = self.collectionView.bounds.size;
//    
//    for (UICollectionViewLayoutAttributes *attrib in attributes) {
//        if (attrib.center.y < visibleRect.origin.y + 180) {
//            attrib.alpha = 0.8f;
//        }   else if (attrib.center.y < visibleRect.origin.y + 140) {
//            attrib.alpha = 0.4f;
//        }  else if (attrib.center.y < visibleRect.origin.y + 100) {
//            attrib.alpha = 0.0f;
//        }
//    }
//    
//    return attributes;
//}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
