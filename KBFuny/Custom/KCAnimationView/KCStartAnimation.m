//
//  KCStartAnimation.m
//  KBFuny
//
//  Created by jinlb on 15/9/14.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import "KCStartAnimation.h"

@implementation KCStartAnimation{

    UIImageView *_cloud_L;
    UIImageView *_cloud_TR;
    UIImageView *_cloud_BR;
    
    UIImageView *_rocket;

}
-(id)init{

    CGFloat  width=[UIScreen  mainScreen].bounds.size.width;
    CGFloat  height=[UIScreen mainScreen].bounds.size.height;
    if (self=[super initWithFrame:CGRectMake(0, 0, width, height)]) {
        //1、背景
        UIImage *bgUimage=[UIImage imageNamed:@"start_background"];
        UIImageView *bgUimageView=[[UIImageView alloc]initWithImage:bgUimage];
        bgUimageView.frame=self.frame;
        [self addSubview:bgUimageView];
        
        //2、星星
        UIImage *star=[UIImage imageNamed:@"start_Star"];
        UIImageView *starImageView=[[UIImageView alloc]initWithImage:star];
        starImageView.frame=CGRectMake(0, 0, 240, 350);
        starImageView.center=CGPointMake(self.frame.size.width/2, 200);
        [self addSubview:starImageView];
        
        //3、云
        UIImage *cloud=[UIImage imageNamed:@"start_Cloud_L"];
        UIImageView *cloudImage=[[UIImageView alloc]initWithImage:cloud];
        cloudImage.frame=CGRectMake(-20, 80, 135, 81);
        _cloud_L=cloudImage;
        [self addSubview:cloudImage];
        
        cloud=[UIImage imageNamed:@"start_Cloud_TR"];
        cloudImage=[[UIImageView alloc]initWithImage:cloud];
        cloudImage.frame=CGRectMake(self.frame.size.width-105, 16, 105, 41);
        _cloud_TR=cloudImage;
        [self addSubview:cloudImage];
        
        cloud=[UIImage imageNamed:@"start_Cloud_BR"];
        cloudImage=[[UIImageView alloc]initWithImage:cloud];
        cloudImage.frame=CGRectMake(self.frame.size.width-130, 140, 117, 58);
        _cloud_BR=cloudImage;
        [self addSubview:cloudImage];
        
        //4、火箭
        UIImage *rocket=[UIImage imageNamed:@"start_Rocket"];
        UIImageView *rocketImageView=[[UIImageView alloc]initWithImage:rocket];
        rocketImageView.frame=CGRectMake(0, 0, 125, 262);
        rocketImageView.center=CGPointMake(self.frame.size.width/2, 97+131);
        [self addSubview:rocketImageView];
        _rocket=rocketImageView;
        
        [self startAnimation];
        
    }
    return self;
}
-(void)startAnimation{
    
    CGFloat moveOffset=30;
    //1、左边云运动
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath=@"transform.translation.x";
    animation.duration=3.0;
    animation.values = @[@(0),
                         @(moveOffset),
                         @(0)];
    CAMediaTimingFunction *fn=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];

    animation.timingFunctions=@[fn,fn];
    animation.repeatCount=15;
    [_cloud_L.layer addAnimation:animation forKey:nil];
    
    //2、右上角云
    animation = [CAKeyframeAnimation animation];
    animation.keyPath=@"transform.translation.x";
    animation.duration=3.0;
    animation.values = @[@(0),
                         @(-moveOffset),
                         @(0)];
    fn=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.timingFunctions=@[fn,fn];
    animation.repeatCount=15;
    [_cloud_TR.layer addAnimation:animation forKey:nil];
    
    //3、右下
    animation = [CAKeyframeAnimation animation];
    animation.keyPath=@"transform.translation.x";
    animation.duration=4.0;
    animation.values = @[@(0),
                         @(-50),
                         @(0)];
    fn=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.timingFunctions=@[fn,fn];
    animation.repeatCount=15;
    [_cloud_BR.layer addAnimation:animation forKey:nil];
    
    
    //4、火箭
//    _rocket.layer.position = CGPointMake(160, -268);
    CGFloat centerX=_rocket.center.x;
    CGFloat centerY=_rocket.center.y;
    
    animation = [CAKeyframeAnimation animation];
    animation.keyPath=@"position";
    animation.duration=3.0;
    animation.values = @[
                         [NSValue valueWithCGPoint:CGPointMake(centerX, centerY-30)],
                         [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)],
                         [NSValue valueWithCGPoint:CGPointMake(centerX, centerY-30)],
                         [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)],
                         [NSValue valueWithCGPoint:CGPointMake(centerX, centerY-200)]
                         ];
    animation.timingFunctions = @[
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]
                                  ];
//    animation.keyTimes = @[@0.0, @0.3, @0.5, @0.7, @1.0];
    animation.keyTimes = @[@0.0, @0.25, @0.5, @0.9, @1.0];

    
    animation.delegate=self;

//    _rocket.layer.position=CGPointMake(160, -200);
    [_rocket.layer addAnimation:animation forKey:nil];
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    _rocket.center=CGPointMake(self.frame.size.width/2, -200);
    
[UIView animateWithDuration:0.2 animations:^{
    self.alpha=0.1;
} completion:^(BOOL finished) {
    [self removeFromSuperview];
}];
}


@end
