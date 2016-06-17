//
//  KBGraphicsView.m
//  KBFuny
//
//  Created by jinlb on 15/3/28.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import "KBGraphicsView.h"

@implementation KBGraphicsView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //1、设置上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //1.1 设置阴影效果
    /*
     * 第一参数：图形上下文
     * 第二个参数：阴影偏移两，x正数为向右便宜位置；y正数为向下偏移位置；
     * 第三次个参数：阴影的模糊度，更有立体感
     */
    CGContextSetShadow(ctx, CGSizeMake(9, 9), 5);
    
    //设置透明度
    CGContextSetAlpha(ctx, 1);
    
  

    //2、设置线条颜色
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
   //3、设置填充颜色
    CGContextSetFillColorWithColor(ctx , [UIColor blueColor].CGColor);
    //4、绘画长方形
    CGContextAddRect(ctx, CGRectMake(50, 50, 100, 100));
    //5、开始填充绘画
    CGContextDrawPath(ctx, kCGPathFill);
    
    
    //B、画三角形
    CGContextMoveToPoint(ctx,90, 150);
    CGContextAddLineToPoint(ctx, 100, 170);
    CGContextAddLineToPoint(ctx, 110, 150);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFill);
    
   

    

}

@end
