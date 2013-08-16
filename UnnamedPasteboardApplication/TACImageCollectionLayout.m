//
//  TACImageCollectionLayout.m
//  Clippings
//
//  Created by Thomas Cole on 8/15/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "TACImageCollectionLayout.h"

@implementation TACImageCollectionLayout

- (CGSize)collectionViewContentSize
{
    CGFloat contentWidth = self.collectionView.bounds.size.width;
    
    CGFloat contentHeight = 0.0f;
    
    CGSize contentSize = CGSizeMake(contentWidth, contentHeight);
    
    return contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [NSArray array];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind withIndexPath:indexPath];
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
    
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    return NO;
}


@end
