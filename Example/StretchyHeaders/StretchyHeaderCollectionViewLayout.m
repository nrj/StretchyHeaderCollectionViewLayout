//
//  StretchyHeaderCollectionViewLayout.m
//  StretchyHeaders
//
//  Created by Nick Jensen on 12/26/13.
//  Copyright (c) 2013 Nick Jensen. All rights reserved.
//

#import "StretchyHeaderCollectionViewLayout.h"

@implementation StretchyHeaderCollectionViewLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}

- (UICollectionViewScrollDirection)scrollDirection {
    
    return UICollectionViewScrollDirectionVertical;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    UICollectionView *collectionView = [self collectionView];
    UIEdgeInsets insets = [collectionView contentInset];
    CGPoint offset = [collectionView contentOffset];
    CGFloat minY = -insets.top;
    
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    if (offset.y < minY) {
        
        CGSize  headerSize = [self headerReferenceSize];
        CGFloat deltaY = fabsf(offset.y - minY);
        
        for (UICollectionViewLayoutAttributes *attrs in attributes) {
            
            if ([attrs representedElementKind] == UICollectionElementKindSectionHeader) {
                
                CGRect headerRect = [attrs frame];
                headerRect.size.height = MAX(minY, headerSize.height + deltaY);
                headerRect.origin.y = headerRect.origin.y - deltaY;
                [attrs setFrame:headerRect];
                break;
            }
        }
    }
    
    return attributes;
}

@end
