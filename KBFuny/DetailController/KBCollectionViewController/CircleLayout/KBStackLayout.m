//
//  KBStackLayout.m
//  KBFuny
//
//  Created by jinlb on 2016/12/13.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBStackLayout.h"
#define kCalcAngle(x) \
        (x) * M_PI / 180.0

@implementation KBStackLayout

//自定义属性
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray<UICollectionViewLayoutAttributes *> *attrs=[[NSMutableArray<UICollectionViewLayoutAttributes *> alloc]init];
    
    NSInteger count=[self.collectionView numberOfItemsInSection:0];
    for (int index=0; index<count; ++index) {
        UICollectionViewLayoutAttributes *attribute=    [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        
        [attrs addObject:attribute];
        
    }
    return attrs;
}

//重写attribute 属性
-(UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //    [super layoutAttributesForItemAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *attribute=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attribute.size=CGSizeMake(60, 60);
    
    //第几个Item
    NSInteger index=indexPath.item;
    
    NSInteger count=[self.collectionView numberOfItemsInSection:0];
    CGFloat singleItemAngle=360.0/count;
    
    //计算各个环绕的center
    
    //圆心
    CGFloat circleX=self.collectionView.frame.size.width*0.5;
    CGFloat circleY=self.collectionView.frame.size.height*0.5;
    //计算各个环绕的center
    attribute.center = CGPointMake(circleX,circleY);

    attribute.transform=CGAffineTransformMakeRotation(kCalcAngle(singleItemAngle*index));
    attribute.zIndex=count-index;
    
    return attribute;
    
}
@end
