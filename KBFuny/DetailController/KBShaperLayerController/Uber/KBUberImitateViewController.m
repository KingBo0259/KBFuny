//
//  KBUberImitateViewController.m
//  KBFuny
//
//  Created by jinlb on 16/8/17.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBUberImitateViewController.h"

@interface KBUberImitateViewController ()

@end

@implementation KBUberImitateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Uber demo";
    
    self.view.backgroundColor=[UIColor yellowColor];
    
    CALayer *layer=[self createCirleLayer];
    [self.view.layer addSublayer:layer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(CALayer*)createRect{

    
    UIBezierPath *bezierLayer= [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 10, 10)];
    CAShapeLayer *shaperLayer=[CAShapeLayer layer];
    shaperLayer.path=bezierLayer.CGPath;
    shaperLayer.lineWidth=1.0;
    shaperLayer.strokeColor=[UIColor yellowColor].CGColor;
    shaperLayer.fillColor=[UIColor yellowColor].CGColor;
    
    

    
    
    return shaperLayer;

}

-(CAShapeLayer*)createCirleLayer{

    
    CGFloat width=50.0f;
    UIBezierPath *bezierPath=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, width, width)];
    
    CAShapeLayer *shaperLayer=[CAShapeLayer layer];
    shaperLayer.path=bezierPath.CGPath;
    shaperLayer.lineWidth=width;
    shaperLayer.strokeColor=[UIColor blueColor].CGColor;
    shaperLayer.fillColor=[UIColor clearColor].CGColor;
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
