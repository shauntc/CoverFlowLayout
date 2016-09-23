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

CGFloat const scaleFactor = 1.5;

-(void)prepareLayout
{
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.itemSize = CGSizeMake(200, 200);
    self.sectionInset = UIEdgeInsetsMake(150, 150, 150, 150);
    self.minimumLineSpacing = 0;
    
    
    
    
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
                    
                    
                    // 0 at x40 -> 45 at x130
                    float degrees = (-xDist/fabs(xDist)) * (45) * ((fabs(xDist)-40)/(90));
                    cellAttributes.transform3D = [self Rotate3dByDegrees:degrees];

                    
                    CGFloat xTransf = scaleFactor - (scaleFactor - 1.0)*((fabs(xDist)-40)/(90));
                    cellAttributes.transform3D = CATransform3DScale(cellAttributes.transform3D, xTransf, xTransf, 0);
                    
                    CGFloat xTranslate = (-xDist/scaleFactor)*(1 - ((fabs(xDist)-40)/(90)));
                    cellAttributes.transform3D = CATransform3DTranslate(cellAttributes.transform3D, xTranslate, 0, 0);
                    
                    
                    //alpha 1 at x40 -> 0.25 at x130
                    CGFloat alpha = 0.25 +  (0.75)*(1-((fabs(xDist)-40)/(90)));
                    cellAttributes.alpha = alpha;
                    
                    
                    

                }
                
            }
            else{
                
                cellAttributes.alpha = 0.25;
                
                if(xDist > 0)
                {
                    cellAttributes.transform3D = [self Rotate3dByDegrees:-45];
                }
                else{
                    cellAttributes.transform3D = [self Rotate3dByDegrees:45];
                }
                
                
            }
            
            
            
            
            
        }
        
    }
    
    
    return attributes;
}


-(CATransform3D)Rotate3dByDegrees:(float)degrees
{
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -200;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, degrees * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
    return rotationAndPerspectiveTransform;
}




//-(CGSize)collectionViewContentSize
//{
//    
//}
//
//-collectionview

@end
