//
//  UIBezirPathViewController.m
//  KBFuny
//
//  Created by jinlb on 16/7/14.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "UIBezierPathViewController.h"

@interface UIBezierPathViewController ()
@property(weak,nonatomic)UIView *topView;
@property(weak,nonatomic)UIView *bootView;

@property(weak,nonatomic)UIView *startView;
@property(weak,nonatomic)UIView *endView;

@property(weak,nonatomic)CAShapeLayer *bezierLineLayer;
@property(weak,nonatomic)CAShapeLayer *bootBezierLineLayer;


@property(strong,nonatomic)NSMutableArray *points;//!< 使用两个点控制曲线制作
@end

@implementation UIBezierPathViewController

-(void)loadView{
    [super loadView];
    
}
#pragma  mark -  VIEW

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self initUI];
}


-(void)initUI{
    
    self.title=@"UIBezierPath";
    [self initTopView];
    [self initBootView];
}




-(void)initTopView{
    
    //topView 三点画布
    UIView * topView=[UIView new];
    self.topView=topView;
    topView.backgroundColor=[UIColor yellowColor];
    topView.userInteractionEnabled=YES;
    
    
    //起点
    UIView *startView=[[UIView alloc]init];
    startView.backgroundColor=[UIColor redColor];
    startView.layer.cornerRadius=2.0f;
    self.startView=startView;
    [topView addSubview:startView];
    
    
    //终点
    UIView *endView=[[UIView alloc]init];
    endView.backgroundColor=[UIColor redColor];
    endView.layer.cornerRadius=2.0f;
    self.endView=endView;
    [topView addSubview:endView];
    
    //滑动手势
    UIPanGestureRecognizer *swipRegcognize=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    //    UITapGestureRecognizer *tapRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    [topView addGestureRecognizer:swipRegcognize];
    [self.view addSubview:topView];
    
    
    UILabel *label=[UILabel new];
    label.text=@"请在两点间拖动，进行绘制Bezier曲线";
    label.textColor=[UIColor blackColor];
    [topView addSubview:label];
    
    [label makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(topView);
        make.left.equalTo(topView).offset(10);
        make.right.equalTo(topView).offset(-10);
        
    }];
    
    [topView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@300);
    }];
    
    [startView makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@4);
        make.top.equalTo(@100);
        make.left.equalTo(@100);
    }];
    
    
    [endView makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@4);
        make.top.equalTo(@100);
        make.left.equalTo(@200);
    }];
    
    [self createBezier1:CGPointMake(150, 150)];

}


-(void)initBootView{

    UIView *bootView=[UIView new];
    bootView.userInteractionEnabled=YES;
    _bootView=bootView;
    bootView.backgroundColor=[UIColor blueColor];
    UIPanGestureRecognizer *swipRegcognize=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(curveClick:)];

    [bootView addGestureRecognizer:swipRegcognize];
    
    
    UIView *startView=[UIView new];
    startView.layer.cornerRadius=2.0f;
    startView.backgroundColor=[UIColor redColor];
    [bootView addSubview:startView];
    
    
    UIView *endView=[UIView new];
    endView.layer.cornerRadius=2.0f;
    endView.backgroundColor=[UIColor redColor];
    [bootView addSubview:endView];
    
    
    UILabel *label=[UILabel new];
    label.text=@"利用两个控制点，进行绘制Bezier曲线";
    label.textColor=[UIColor yellowColor];
    [bootView addSubview:label];

    
    [self.view addSubview:bootView];
    
    
    //构建四个点 。。。 起点终点，两个控制点
    NSValue *start= [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue *control1= [NSValue valueWithCGPoint:CGPointMake(150, 50)];
    NSValue *control2= [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    NSValue *end= [NSValue valueWithCGPoint:CGPointMake(300, 100)];
    _points=[[NSMutableArray alloc]initWithObjects: start,control1,control2,end, nil];
    
    
    
    
    [bootView makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.bottom.equalTo(self.view);
    make.top.equalTo(_topView.bottom);
    }];
    
    [startView makeConstraints:^(MASConstraintMaker *make) {
        make.center.centerX.equalTo(@100.);
        make.center.centerY.equalTo(@100.);

        make.height.with.equalTo(@4.0f);
    }];
    
    [endView makeConstraints:^(MASConstraintMaker *make) {
        make.center.centerX.equalTo(@300.);
        make.center.centerY.equalTo(@100.);
        make.height.with.equalTo(@4.0f);
    }];
    
    [label makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(bootView);
        make.left.equalTo(bootView).offset(10);
        make.right.equalTo(bootView).offset(-10);
        
    }];

    [self createBezire];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  - DATA

#pragma mark - PRIVATE 

-(float)distanceFromPointX:(CGPoint)start distanceToPointY:(CGPoint)end{
    float distance;
    //下面就是高中的数学，不详细解释了
    CGFloat xDist = (end.x - start.x);
    CGFloat yDist = (end.y - start.y);
    distance = sqrt((xDist * xDist) + (yDist * yDist));
    return distance;
}

-(void)curveClick:(UIGestureRecognizer*)sender{
    CGPoint clickPoint= [sender locationInView:self.bootView];
    
    if (self.bootBezierLineLayer) {
        [self.bootBezierLineLayer removeFromSuperlayer];
    }


    NSValue *controlPoint1=_points[1];
    NSValue *controlPoint2=_points[2];
    //计算距离离哪个control近，就替换
    float distance1=[self distanceFromPointX:clickPoint distanceToPointY:[controlPoint1 CGPointValue]];
    float distance2=[self distanceFromPointX:clickPoint distanceToPointY:[controlPoint2 CGPointValue]];

    if (distance1<=distance2) {
        _points[1]=[NSValue valueWithCGPoint:clickPoint];
    }else{
        _points[2]=[NSValue valueWithCGPoint:clickPoint];
    }
    
    [self createBezire];

}


-(void)createBezire{

    self.bootBezierLineLayer= [self curveStartPoint:[_points[0] CGPointValue] ToPoint:[_points[3] CGPointValue] controlPoint1:[_points[1] CGPointValue] controlPoint2:[_points[2] CGPointValue]];
    
    [self.bootView.layer addSublayer:self.bootBezierLineLayer];
    

}


- (void)createBezier1:(CGPoint)clickPoint {
    CGPoint start ,end;
    start=self.startView.center;
    end=self.endView.center;
    
    self.bezierLineLayer=[self bezierPathWithStart:start end:end controlPoint:clickPoint];
    
    [self.topView .layer addSublayer:self.bezierLineLayer];
}

-(void)click:(UIGestureRecognizer*)sender{
   CGPoint clickPoint= [sender locationInView:self.topView];
    
    if (self.bezierLineLayer) {
        [self.bezierLineLayer removeFromSuperlayer];
    }
    
    [self createBezier1:clickPoint];

}

-(CAShapeLayer*)bezierPathWithStart:(CGPoint)start
                                end:(CGPoint)end
                       controlPoint:(CGPoint)controlPoint{
    
    
    UIBezierPath *bezierPath=[UIBezierPath bezierPath];
    [bezierPath moveToPoint:start];
    [bezierPath addQuadCurveToPoint:end controlPoint:controlPoint];
    
    
    CAShapeLayer *shaperLayer=[CAShapeLayer layer];
    shaperLayer.path=bezierPath.CGPath;
    shaperLayer.strokeColor=[UIColor redColor].CGColor;
    shaperLayer.lineWidth=2.0f;
    shaperLayer.fillColor=[UIColor clearColor].CGColor;//否则默认为黑色
    return shaperLayer;

}

-(CAShapeLayer*) curveStartPoint:(CGPoint)startPint
                         ToPoint:(CGPoint)endPoint
                   controlPoint1:(CGPoint)controlPoint1
                   controlPoint2:(CGPoint)controlPoint2{
    UIBezierPath *bezierPath=[UIBezierPath bezierPath];
    [bezierPath moveToPoint:startPint];
    [bezierPath addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];

    CAShapeLayer *shaperLayer=[CAShapeLayer layer];
    shaperLayer.path=bezierPath.CGPath;
    shaperLayer.strokeColor=[UIColor redColor].CGColor;
    shaperLayer.lineWidth=2.0f;
    shaperLayer.fillColor=[UIColor clearColor].CGColor;//否则默认为黑色
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
