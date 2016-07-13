//
//  KBCALayerFactory.m
//  KBFuny
//
//  Created by jinlb on 16/7/12.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBCALayerFactory.h"

@implementation KBCALayerFactory
/**
 *  创建自定义shaperLayer
 *
 *  @param view 父view
 *
 *  @return CAShaperLayer
 */
+(CAShapeLayer*)createShaperWithView:(UIView*)view{

    
    CGFloat viewWidth = CGRectGetWidth(view.frame);
    CGFloat viewHeight = CGRectGetHeight(view.frame);
    CGFloat rightSpace = 10.;
    CGFloat topSpace = 15.;
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(viewWidth-rightSpace, 0);
    CGPoint point3 = CGPointMake(viewWidth-rightSpace, topSpace);
    CGPoint point4 = CGPointMake(viewWidth, topSpace);
    CGPoint point5 = CGPointMake(viewWidth-rightSpace, topSpace+10.);
    CGPoint point6 = CGPointMake(viewWidth-rightSpace, viewHeight);
    CGPoint point7 = CGPointMake(0, viewHeight);
    
    
    
    UIBezierPath *path=[[UIBezierPath alloc]init];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    [path addLineToPoint:point7];
    [path closePath];
    
    
    CAShapeLayer *shaperLayer=[CAShapeLayer layer];
    shaperLayer.path=path.CGPath;
    return shaperLayer;

}

/**
 *  圆形进度条
 *
 *  @return
 */
+(CAShapeLayer*)circlProgressLayerWithWidth:(CGFloat)width{

    CAShapeLayer *shaperLayer=[CAShapeLayer layer];
    
    //画内切圆
    UIBezierPath *path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, width, width)];
    shaperLayer.path=path.CGPath;
    shaperLayer.fillColor=[UIColor clearColor].CGColor;
    shaperLayer.lineWidth=10.;
    shaperLayer.strokeColor=[UIColor redColor].CGColor;
    //添加动画
    CABasicAnimation *pathAnima=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration=2.0f;
    pathAnima.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue=@0.0f;
    pathAnima.toValue=@1.0f;
    pathAnima.fillMode=kCAFillModeForwards;
    pathAnima.removedOnCompletion=YES;
    
    [shaperLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
    return shaperLayer;
}
@end
