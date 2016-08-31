//
//  KBImageFloderTableViewController.m
//  KBFuny
//
//  Created by jinlb on 16/8/30.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBImageFloderTableViewController.h"



static const CGFloat IMAGE_PER_HEIGIT=65.0f;
static const CGFloat IMAGE_WIDTH=125.0f;

@interface KBImageFloderTableViewController (){

    UIImageView *_one;
    UIImageView *_two;
    UIImageView *_three;
    UIImageView *_four;
    
    UIView *_oneShadowView;
    UIView *_threeShadowView;
    
}

@end

@implementation KBImageFloderTableViewController

#pragma mark - VIEW
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
 
}

-(void)initUI{
    
    self.title=@"图片折叠效果";
    self.view.backgroundColor=[UIColor blackColor];
    
    UIButton *button=[UIButton new];
    button.backgroundColor=[UIColor redColor];
    [button setTitle:@"折叠" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fold:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *unButton=[UIButton new];
    [unButton setTitle:@"恢复" forState:UIControlStateNormal];
    [unButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [unButton setBackgroundColor:[UIColor yellowColor]];
    [unButton addTarget:self action:@selector(unfold:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:unButton];

    
    
    
    
    
    [button makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.height.equalTo(@60);
        make.top.equalTo(@64);
        
    }];
    
    [unButton makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view);
        make.top.width.height.equalTo(button);
        make.left.equalTo(button.right);
    }];
    
    
    
    CGFloat left=100,top=150;

    
    UIImage *image=[UIImage imageNamed:@"start_background"];
    UIImageView *one=[[UIImageView alloc]initWithImage:image];
    _one=one;
    one.layer.anchorPoint=CGPointMake(0.5, 0.0);//设置anchorPoint、frame 先后不一样会导致不同的布局
    one.frame=CGRectMake(left, top, IMAGE_WIDTH, IMAGE_PER_HEIGIT);
    one.layer.contentsRect=CGRectMake(0, 0, 1, 0.25);//获取 1／4 部分图片
    [self.view addSubview:one];
    
    
    top+=IMAGE_PER_HEIGIT;
    UIImageView *two=[[UIImageView alloc]initWithImage:image];
    _two=two;
    two.layer.anchorPoint=CGPointMake(0.5, 1.0);
    two.frame=CGRectMake(left, top, IMAGE_WIDTH, IMAGE_PER_HEIGIT);
    two.layer.contentsRect=CGRectMake(0, 0.25, 1, 0.25);//获取 1／4 部分图片
    [self.view addSubview:two];

    
    top+=IMAGE_PER_HEIGIT;
    UIImageView *three=[[UIImageView alloc]initWithImage:image];
    _three=three;
    three.layer.anchorPoint=CGPointMake(0.5, 0.0);
    three.frame=CGRectMake(left, top, IMAGE_WIDTH, IMAGE_PER_HEIGIT);
    three.layer.contentsRect=CGRectMake(0, 0.5, 1, 0.25);//获取 1／4 部分图片
    [self.view addSubview:three];
    
    top+=IMAGE_PER_HEIGIT;
    UIImageView *four=[[UIImageView alloc]initWithImage:image];
    _four=four;
    four.layer.anchorPoint=CGPointMake(0.5, 1.0);
    four.frame=CGRectMake(left, top, IMAGE_WIDTH, IMAGE_PER_HEIGIT);
    four.layer.contentsRect=CGRectMake(0, 0.75, 1, 0.25);//获取 1／4 部分图片
    [self.view addSubview:four];

    
    // 给第一张和第三张添加阴影
    
    _oneShadowView=[[UIView alloc]initWithFrame:_one.bounds];
    _oneShadowView.backgroundColor=[UIColor blackColor];
    _oneShadowView.alpha=0.0f;
    [_one addSubview:_oneShadowView];
    
    
    _threeShadowView=[[UIView alloc]initWithFrame:_one.bounds];
    _threeShadowView.backgroundColor=[UIColor blackColor];
    _threeShadowView.alpha=0.0f;
    [_three addSubview:_threeShadowView];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)unfold:(id)sener{

    [UIView animateWithDuration:1.0
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         // 阴影隐藏
                         _oneShadowView.alpha = 0.0;
                         _threeShadowView.alpha = 0.0;
                         
                         // 图片恢复原样
                         _one.layer.transform = CATransform3DIdentity;
                         _two.layer.transform = CATransform3DIdentity;
                         _three.layer.transform = CATransform3DIdentity;
                         _four.layer.transform = CATransform3DIdentity;
                         
                     } completion:^(BOOL finished) {
                         
                     }];
    
}
-(void)fold:(id)sender{
    [UIView animateWithDuration:1.0
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         // 阴影显示
                         _oneShadowView.alpha = 0.2;
                         _threeShadowView.alpha = 0.2;
                         
                         // 折叠 (这里需要设置角度和  y 坐标)
                         _one.layer.transform = [self config3DTransformWithRotateAngle:-45.0
                                                                          andPositionY:0];
                         _two.layer.transform = [self config3DTransformWithRotateAngle:45.0
                                                                          andPositionY:-100+_one.frame.size.height];
                         _three.layer.transform = [self config3DTransformWithRotateAngle:-45.0
                                                                            andPositionY:-100+_one.frame.size.height];
                         _four.layer.transform = [self config3DTransformWithRotateAngle:45.0
                                                                           andPositionY:-147+_one.frame.size.height];
                         
                     } completion:^(BOOL finished) {
                         
                         
                     }];
}



-(CATransform3D)config3DTransformWithRotateAngle:(double)angle andPositionY:(double)postionY{

    CATransform3D transfrom=CATransform3DIdentity;
    //立体(设置透视度)
    transfrom.m34=-1/500.0;
    //旋转
    CATransform3D rotationTransform=CATransform3DRotate(transfrom, M_PI*angle/180, 1, 0, 0);
    
    // 移动(这里的y坐标是平面移动的的距离,我们要把他转换成3D移动的距离.这是关键,没有它,图片就没办法很好地对接。)
    CATransform3D moveTransform=CATransform3DMakeAffineTransform(CGAffineTransformMakeTranslation(0, postionY));
    
    //合并
    CATransform3D contactTransform=CATransform3DConcat(rotationTransform, moveTransform);
    
    return  contactTransform;

}

@end
