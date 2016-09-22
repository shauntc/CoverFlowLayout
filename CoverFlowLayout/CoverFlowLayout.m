//
//  CoverFlowLayout.m
//  InstaKilo
//
//  Created by Shaun Campbell on 2016-09-22.
//  Copyright © 2016 Shaun Campbell. All rights reserved.
//

#import "CoverFlowLayout.h"

@interface CoverFlowLayout()

@property (nonatomic) NSArray <UICollectionViewLayoutAttributes *> *attributesArray;

@end


@implementation CoverFlowLayout

CGFloat const scaleFactor = 3.0;

-(void)prepareLayout
{
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.itemSize = CGSizeMake(100, 100);
    self.sectionInset = UIEdgeInsetsMake(150, 150, 150, 150);
    self.minimumLineSpacing = 100;
    
    
    
    
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    CGRect visibleRegion;
    visibleRegion.origin = self.collectionView.contentOffset;
    visibleRegion.size = self.collectionView.bounds.size;
    
    for(UICollectionViewLayoutAttributes *cellAttributes in attributes)
    {
        if(CGRectIntersectsRect(rect, cellAttributes.frame))
        {
         
            CGFloat xDist = (cellAttributes.center.x) - (visibleRegion.origin.x + (visibleRegion.size.width/2));
            
            if(fabs(xDist) <= 130)
            {
            
                if(fabs(xDist)<40)
                {
                    cellAttributes.transform3D = CATransform3DMakeScale(scaleFactor, scaleFactor, 0);
                    cellAttributes.transform3D = CATransform3DTranslate(cellAttributes.transform3D, -xDist/scaleFactor, 0, 0);
                }
                else{
                    CGFloat xTransf = scaleFactor - (scaleFactor - 1.0)*((fabs(xDist)-40)/(90));
                    cellAttributes.transform3D = CATransform3DMakeScale(xTransf, xTransf, 0);
                    
                    CGFloat xTranslate = (-xDist/scaleFactor)*(1 - ((fabs(xDist)-40)/(90)));
                    cellAttributes.transform3D = CATransform3DTranslate(cellAttributes.transform3D, xTranslate, 0, 0);
                }
                
            }
            else
            {
                cellAttributes.alpha = 0.25;
//                cellAttributes.transform3D = CA
            }
            
            
            
            
            
        }
        
    }
    
    
    return attributes;
}

//-(CGSize)collectionViewContentSize
//{
//    
//}
//
//-collectionview

@end
