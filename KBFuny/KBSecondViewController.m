//
//  KBSecondViewController.m
//  KBFuny
//
//  Created by jinlb on 15/4/17.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import "KBSecondViewController.h"

@interface KBSecondViewController ()<UIGestureRecognizerDelegate>
- (IBAction)changeColorClick:(id)sender;
@property(nonatomic,strong) CALayer *colorLayer;
@property (weak, nonatomic) IBOutlet UIView *layerVIew;
@property (nonatomic, strong) UIView *colorView;
@property (weak, nonatomic) IBOutlet UIImageView *ballImageView;
@end

@implementation KBSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self UISetup];
    

    // 获取系统自带滑动手势的target对象
//    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
}


-(void)handleNavigationTransition:(id)sender{
    
    NSLog(@"panGesture");

}



-(void)UISetup
{
    
    //1、 Layer层 缓冲动画实现方式
    self.colorLayer=[CALayer layer];
    self.colorLayer.frame=CGRectMake(0,0,100,100);
    self.colorLayer.position=CGPointMake(self.view.bounds.size.width/2.0,self.view.bounds.size.height/2.0);
    self.colorLayer.backgroundColor=[UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
    
    //2、UIView 类型 缓冲动画
    self.colorView=[[UIView alloc] init];
    self.colorView.frame=CGRectMake(0,0,100,100);
    self.colorView.center=CGPointMake(self.view.bounds.size.width/2.0,self.view.bounds.size.height/2.0);
    self.colorView.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.colorView];
    

    
    
    /*
     使用UIInterpolatingMotionEffect可以使页面随着设备在空间的移动而发生微移
     */
    
    //x 动画效果
    UIInterpolatingMotionEffect *xEffect= [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    xEffect.minimumRelativeValue=@(-80);
    xEffect.maximumRelativeValue=@(80);
    //y 动画效果
    UIInterpolatingMotionEffect *yEffect=[[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    UIMotionEffectGroup *motionGroup=[UIMotionEffectGroup new];
    yEffect.minimumRelativeValue=@(-80);
    xEffect.maximumRelativeValue=@(80);
    
    motionGroup.motionEffects=@[xEffect,yEffect];
    
    [self.layerVIew addMotionEffect:motionGroup];

    

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    //A  使用containsPoint判断被点击的图层
    //get touch position relative to main view
    CGPoint point=[[touches anyObject] locationInView:self.view];
     point= [self.layerVIew.layer convertPoint:point fromLayer:self.view.layer];
        if([self.layerVIew.layer containsPoint:point])
    {
    
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"我被点击了" message:nil delegate:nil
            cancelButtonTitle:@"确定" otherButtonTitles:nil , nil];
        

        [alertView show];
        return;
    }
    
    //B  使用hitTest判断被点击的图层
    
    
    
    
//    1、 Layer层 缓冲动画实现方式
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] ];
    self.colorLayer.position=[[touches anyObject] locationInView:self.view];
    [CATransaction commit];
    
//    //2、UIView 类型 缓冲动画
//    [UIView animateWithDuration:1.0 delay:0.0
//                        options:UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         //set the position
//                         self.colorView.center = [[touches anyObject] locationInView:self.view];
//                     }
//                     completion:NULL];
//

}
- (IBAction)changeColorClick:(UIButton*)sender {
    //add timing function

    if (sender.tag==0) {
        self.colorLayer.backgroundColor=[UIColor blueColor].CGColor ;

        
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath=@"backgroundColor";
    animation.duration=2.0;
    animation.values = @[(__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor ];
    CAMediaTimingFunction *fn=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.timingFunctions=@[fn,fn,fn];
        animation.delegate=self;
        [self.colorLayer addAnimation:animation forKey:nil];
    }else if (sender.tag==1)
    {
        
//        self.layerVIew.frame=CGRectMake(0, 0, 320, 480);
        CAMediaTimingFunction *function=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        //getCotrolPoint1 ,getControlPoint2
        CGPoint point1,point2;
        [function getControlPointAtIndex:1 values:(float*)&point1];
        [function getControlPointAtIndex:2 values:(float*)&point2];

        //create curve
        UIBezierPath *bezierPath=[[UIBezierPath alloc]init];
        [bezierPath moveToPoint:CGPointZero];
        [bezierPath addCurveToPoint:CGPointMake(1, 1) controlPoint1:point1 controlPoint2:point2];
        [bezierPath applyTransform:CGAffineTransformMakeScale(200, 200)];
        
        //create shaper layer
        CAShapeLayer *shaplerLayer=[CAShapeLayer layer];
        shaplerLayer.strokeColor=[UIColor redColor].CGColor;
        shaplerLayer.fillColor=[UIColor clearColor].CGColor;
        shaplerLayer.lineWidth=4.0f;
        shaplerLayer.path=bezierPath.CGPath;
        [self.layerVIew.layer addSublayer:shaplerLayer];
        
      //flip geometry so that 0,0 is in the bottom-left
        self.layerVIew.layer.geometryFlipped=YES;
    
    }else if (sender.tag==2)
    {
    
        [self animate];
    }else if (sender.tag==3)
    {
    
    
        [UIView animateWithDuration:0.4 animations:^{
            CATransform3D transForm=CATransform3DIdentity;
            transForm=CATransform3DRotate(transForm, M_PI_4, 1, 1, 1);
            self.colorView.layer.transform=transForm;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.4 animations:^{
                CATransform3D transForm=CATransform3DIdentity;
                transForm=CATransform3DRotate(transForm, 0, 1, 1, 1);
                self.colorView.layer.transform=transForm;
                

            }];
            
        }];
        
        
    }
    
    
}


-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{


    return YES;
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{


    NSLog(@"animationDidStop");
}

- (void)animate
{
    
    
    //reset ball to top of screen
    self.ballImageView.center = CGPointMake(150, 32);
    //create keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 1.0;
    animation.delegate = self;
    animation.values = @[
                         [NSValue valueWithCGPoint:CGPointMake(150, 32)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 140)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 220)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 250)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)]
                         ];
    animation.timingFunctions = @[
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]
                                  ];
    animation.keyTimes = @[@0.0, @0.3, @0.5, @0.7, @0.8, @0.9, @0.95, @1.0];
    //apply animation
    self.ballImageView.layer.position = CGPointMake(150, 268);
    [self.ballImageView.layer addAnimation:animation forKey:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
