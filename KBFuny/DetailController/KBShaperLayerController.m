//
//  KBShaperLayerController.m
//  KBFuny
//
//  Created by jinlb on 15/4/26.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import "KBShaperLayerController.h"
#import "UIImage+KBImage.h"


@interface KBShaperLayerController ()
@property (nonatomic,strong) CALayer *shipLayer;
@end

@implementation KBShaperLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self UIInit];
}

-(void)UIInit{
    
    //粒子效果
    [self lizixiaoguo];

    //1、划圆
    UIBezierPath *bezierPath=[UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:30 startAngle:0 endAngle:2*M_PI clockwise:0];
    CAShapeLayer *shaperLayer=[CAShapeLayer layer];
    shaperLayer.path=bezierPath.CGPath;
    shaperLayer.strokeColor=[UIColor redColor].CGColor;
    shaperLayer.lineWidth=2;
    shaperLayer.fillColor=[UIColor greenColor].CGColor;
    [self.view.layer addSublayer:shaperLayer];
    
    
    //2、画长方形(圆角任意)
    CGRect rect=CGRectMake(100, 150, 100, 40);
    UIRectCorner rectCorners=UIRectCornerBottomLeft|UIRectCornerTopLeft;
    CGSize conerRadii=CGSizeMake(10, 2);
    bezierPath=[UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:rectCorners cornerRadii:conerRadii];
    shaperLayer=[CAShapeLayer layer];
    shaperLayer.path=bezierPath.CGPath;
    shaperLayer.strokeColor=[UIColor redColor].CGColor;
    shaperLayer.lineWidth=1;
    shaperLayer.fillColor=[UIColor greenColor].CGColor;
    [self.view.layer addSublayer:shaperLayer];

    //3、add 按钮
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Start" forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 60, 80, 40);
    [button addTarget:self action:@selector(drawBezierPath) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Stop" forState:UIControlStateNormal];
    button.frame=CGRectMake(80, 60, 80, 40);
    [button addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIBezierPath *bezierPaht=[[UIBezierPath alloc]init];
    [bezierPaht moveToPoint:CGPointMake(50,100)];
    [bezierPaht addCurveToPoint:CGPointMake(200, 300) controlPoint1:CGPointMake(0, 150) controlPoint2:CGPointMake(250, 250)];
    
     shaperLayer=[[CAShapeLayer alloc]init];
    shaperLayer.path=bezierPaht.CGPath;
    shaperLayer.fillColor=[UIColor clearColor].CGColor;
    shaperLayer.strokeColor=[UIColor redColor].CGColor;
    shaperLayer.lineWidth=3.0;

    [self.view.layer addSublayer:shaperLayer];
    
    

    CALayer *shipLayer=[CALayer layer];
    shipLayer.frame=CGRectMake(0, 0, 22, 22);
    shipLayer.position=CGPointMake(50, 100);
    shipLayer.contents=(__bridge id)[UIImage imageNamed:@"ship"].CGImage;
    self.shipLayer=shipLayer;
    [self.view.layer addSublayer:shipLayer];
    
    
    
    
    
    UIImage*imge=[UIImage renderImageWithColor:[UIColor greenColor] inSize:CGSizeMake(100, 100)];
    UIImageView *imageView=[[UIImageView alloc]initWithImage:imge];
    imageView.center=CGPointMake(160, 340);
    [self.view addSubview:imageView];
    
    
    
    //毛玻璃效果最新方法
    UIVisualEffectView *visualEffect = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    
//    visualEffect.frame = CGRectMake(20, 90, 280, 300);
    visualEffect.frame=CGRectZero;
    visualEffect.alpha = 0.8;
    
    [self.view addSubview:visualEffect];
    
    [visualEffect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@(200));
    }];
    
    

    
 }

-(void)lizixiaoguo{
    // =================== 背景图片 ===========================
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    backgroundView.image = [UIImage imageNamed:@"樱花树1"];
    backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backgroundView];
    
    
    // =================== 樱花飘落 ====================
    CAEmitterLayer * snowEmitterLayer = [CAEmitterLayer layer];
    snowEmitterLayer.emitterPosition = CGPointMake(100, -30);
    snowEmitterLayer.emitterSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    snowEmitterLayer.emitterMode = kCAEmitterLayerOutline;
    snowEmitterLayer.emitterShape = kCAEmitterLayerLine;
    //    snowEmitterLayer.renderMode = kCAEmitterLayerAdditive;
    
    CAEmitterCell * snowCell = [CAEmitterCell emitterCell];
    snowCell.contents = (__bridge id)[UIImage imageNamed:@"樱花瓣2"].CGImage;
    
    // 花瓣缩放比例
    snowCell.scale = 0.02;
    snowCell.scaleRange = 0.5;
    
    // 每秒产生的花瓣数量
    snowCell.birthRate = 7;
    snowCell.lifetime = 80;
    
    // 每秒花瓣变透明的速度
    snowCell.alphaSpeed = -0.01;
    
    // 秒速“五”厘米～～
    snowCell.velocity = 40;
    snowCell.velocityRange = 60;
    
    // 花瓣掉落的角度范围
    snowCell.emissionRange = M_PI;
    
    // 花瓣旋转的速度
    snowCell.spin = M_PI_4;
    
    // 每个cell的颜色
    //    snowCell.color = [[UIColor redColor] CGColor];
    
    // 阴影的 不透明 度
    snowEmitterLayer.shadowOpacity = 1;
    // 阴影化开的程度（就像墨水滴在宣纸上化开那样）
    snowEmitterLayer.shadowRadius = 8;
    // 阴影的偏移量
    snowEmitterLayer.shadowOffset = CGSizeMake(3, 3);
    // 阴影的颜色
    snowEmitterLayer.shadowColor = [[UIColor whiteColor] CGColor];
    
    
    snowEmitterLayer.emitterCells = [NSArray arrayWithObject:snowCell];
    [backgroundView.layer addSublayer:snowEmitterLayer];
    

    

}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    
    //这里是设置导航栏颜色
    CGFloat navigationHight=1;
    CGFloat navigationWight=1;
    
    UIImage*imge=[UIImage renderImageWithColor:[UIColor whiteColor] inSize:CGSizeMake(navigationWight,navigationHight)];
    [self.navigationController.navigationBar setBackgroundImage:imge forBarMetrics:UIBarMetricsDefault];
    
    
    imge=[UIImage renderImageWithColor:[UIColor greenColor] inSize:CGSizeMake(navigationWight,navigationHight)];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:imge];
    
    imge=[UIImage renderImageWithColor:[UIColor redColor] inSize:CGSizeMake(navigationWight,navigationHight)];
    [self.navigationController.navigationBar setShadowImage:imge];
    
    
    
    
}

-(void)drawBezierPath{

    _shipLayer.position=CGPointMake(200, 300);

    UIBezierPath *bezierPaht=[[UIBezierPath alloc]init];
    [bezierPaht moveToPoint:CGPointMake(50,100)];
    [bezierPaht addCurveToPoint:CGPointMake(200, 300) controlPoint1:CGPointMake(0, 150) controlPoint2:CGPointMake(250, 250)];
    
    
    CAKeyframeAnimation *keyFramAnimation=[[CAKeyframeAnimation alloc]init];
    keyFramAnimation.path=bezierPaht.CGPath;
    keyFramAnimation.keyPath=@"position";
    keyFramAnimation.duration=1.0;
    keyFramAnimation.rotationMode=kCAAnimationRotateAuto;//让图片自动调节方向
    keyFramAnimation.delegate=self;
    [_shipLayer addAnimation:keyFramAnimation forKey:@"shipLayerAnimation"];
    

}

-(void)stop{
    [_shipLayer removeAnimationForKey:@"shipLayerAnimation"];


}

-(void)animationDidStop:(CAKeyframeAnimation *)anim finished:(BOOL)flag{

    NSLog(@"StopValue:%@",anim.values);
//    _shipLayer.position=CGPointMake(200, 300);

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
