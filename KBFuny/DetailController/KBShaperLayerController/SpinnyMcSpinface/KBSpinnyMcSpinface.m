//
//  KBSpinnyMcSpinface.m
//  KBFuny
//
//  Created by jinlb on 2017/7/13.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import "KBSpinnyMcSpinface.h"

@implementation KBSpinnyMcSpinface

-(instancetype)initWithNumberOfItems:(NSUInteger)number {
    if (self = [self init]) {
        self.masksToBounds = NO;
        self.frame = CGRectMake(0, 0, KB_SCREEN_WIDTH, KB_SCREEN_HEIGHT);
        for (NSUInteger index = 0; index < number; index++) {
           CALayer *layer = [self generLayerWithSize:CGSizeMake(100, 100) index:index];
            [self insertSublayer:layer atIndex:0];
            [self setZPosition:(CGFloat)index forLayer:layer];
        }
        
        //设置本视图 设置3D效果
        [self rotateParentLayer:60];
    }
    return self;
}

-(CAShapeLayer*)generLayerWithSize:(CGSize)size index:(NSInteger)index {
    CAShapeLayer *square = [CAShapeLayer layer];
    square.path = [UIBezierPath   bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:size.width/4 ].CGPath;
    square.bounds = CGPathGetBoundingBox(square.path);
    square.fillColor = [self randColor].CGColor;
    square.position = CGPointMake(150,200);
    [self setAnchorPoint:CGPointMake(0.5, 0.5) forLayer:square];
    return square;
}
// Because adjusting the anchorPoint itself adjusts the frame, this is needed to avoid it, and keep the layer stationary.
-(void)setAnchorPoint:(CGPoint)anchorPoint forLayer:(CALayer*)layer {
    CGPoint newPoint = CGPointMake(layer.bounds.size.width * anchorPoint.x, layer.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(layer.bounds.size.width * layer.anchorPoint.x, layer.bounds.size.height * layer.anchorPoint.y);
    
    CGPoint position = layer.position;
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    layer.position = position;
    layer.anchorPoint = anchorPoint;
}


-(void)setZPosition:(CGFloat)zPosition forLayer:(CALayer*)layer {
    layer.zPosition = zPosition * (-20);
}


#pragma mark - Animation
-(void)startAnimation{
    CGFloat offsetTime = 0.0;
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / -500.0;
    transform = CATransform3DRotate(transform,M_PI, 0, 0, 1);
    [CATransaction begin];
    for (CALayer *layer in self.sublayers) {
        CABasicAnimation *animation = [self getPinForTranform:transform];
        animation.beginTime = [layer  convertTime:CACurrentMediaTime() toLayer:nil] + offsetTime;
        [layer addAnimation:animation forKey:nil];
        offsetTime += 0.1;
    }
    [CATransaction commit];

}

-(void)stopAnimation {
    for (CALayer *layer in self.sublayers) {
        [layer removeAllAnimations];
    }
}

-(CABasicAnimation*)getPinForTranform:(CATransform3D )transform {
    CABasicAnimation *basic =[CABasicAnimation animationWithKeyPath:@"transform"];
    basic.toValue = [NSValue valueWithCATransform3D:transform];
    basic.duration = 1.0;
    basic.fillMode = kCAFillModeForwards;
    basic.repeatCount = HUGE;
    basic.autoreverses = YES;
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    basic.removedOnCompletion = NO;
    return basic;

}

#pragma mark - 公共方法
//设置本layer 在父layer 中展示3D效果
-(void)rotateParentLayer:(CGFloat)toDegree {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / -500.0;
    transform = CATransform3DRotate(transform, [self degreesToRadians:toDegree], 1, 0, 0);
    self.transform = transform;
}

//角度转弧度
-(CGFloat)degreesToRadians:(CGFloat)degrees {
    return ((M_PI * (degrees)) / 180.0);
}

-(UIColor*)randColor {
    CGFloat red =0.0 ,green = 0.0,blue = 0.0 ;
    red  = (CGFloat)(1+arc4random()%99)/100;
    green  = (CGFloat)(1+arc4random()%99)/100;
    blue  = (CGFloat)(1+arc4random()%99)/100;
    UIColor *randColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    return randColor;
}
@end
