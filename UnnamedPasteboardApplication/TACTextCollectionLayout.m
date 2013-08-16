//
//  TACTextCollectionLayout.m
//  Clippings
//
//  Created by Thomas Cole on 8/15/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "TACTextCollectionLayout.h"

@implementation TACTextCollectionLayout

- (CGSize)collectionViewContentSize
{
    
    return CGSizeMake(200, 200);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    return [NSArray array];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return nil;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}

@end
