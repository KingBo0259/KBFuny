//
//  KBCircleLayout.m
//  KBFuny
//
//  Created by jinlb on 2016/12/13.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBCircleLayout.h"
#define kCalcAngle(x) x * M_PI / 180.0


@implementation KBCircleLayout
-(instancetype)init{
    
    
    if (self=[super init]) {
        
    }
    return self;
}

#pragma mark - 重写父类方法
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
}

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
    
    //半径
    CGFloat radius=100.0;
    
    //圆心
    CGFloat circleX=self.collectionView.frame.size.width*0.5;
    CGFloat circleY=self.collectionView.frame.size.height*0.5;
    
    NSInteger count=[self.collectionView numberOfItemsInSection:0];
    CGFloat singleItemAngle=360.0/count;
    
    //计算各个环绕的center
    // 计算各个环绕的图片center
    attribute.center = CGPointMake(circleX + radius * cosf(kCalcAngle(singleItemAngle * index)), circleY - radius * sinf(kCalcAngle(singleItemAngle * index)));
    

    return attribute;
    
}
@end
