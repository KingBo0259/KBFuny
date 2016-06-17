//
//  KBGradientCircle.m
//  KBFuny
//
//  Created by jinlb on 15/5/4.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import "KBGradientCircleView.h"

@implementation KBGradientCircleView


-(id)initWithFrame:(CGRect)frame withRadius:(CGFloat)radius withColor:(UIColor *)color{

    self=[super initWithFrame:frame];
    if (self) {
     
        _radius=radius;
        _centerPoint=CGPointMake(frame.size.width/2, frame.size.height/2);
        
        CGFloat a;
        [color getRed:&_r green:&_g blue:&_b alpha:&a];
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    _centerPoint=CGPointMake(50, 50);
//    _radius=50;
    
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
//    CGFloat components[8]={
//        1.0, 1.0, 0.0, _colorAlpha,     //start color(r,g,b,alpha)
//        1.0, 1.0, 1.0, 0.0      //end color
//    };
    
    CGFloat components[8]={
        _r, _g, _b, _colorAlpha, //start color(r,g,b,alpha)
        1.0, 1.0, 1.0, 0.0       //end color
    };
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, NULL,2);
    CGColorSpaceRelease(space),space=NULL;//release
    CGPoint start=_centerPoint;
    CGPoint end =_centerPoint;
    CGFloat startRadius = 0.0f;
    CGFloat endRadius =_radius;
    CGContextRef graCtx = UIGraphicsGetCurrentContext();
    CGContextDrawRadialGradient(graCtx, gradient, start, startRadius, end, endRadius, 0);
    CGGradientRelease(gradient),gradient=NULL;//release
}


@end
