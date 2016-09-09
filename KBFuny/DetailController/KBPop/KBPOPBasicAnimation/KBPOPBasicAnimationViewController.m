//
//  KBPOPBasicAnimationViewController.m
//  KBFuny
//
//  Created by jinlb on 16/9/8.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBPOPBasicAnimationViewController.h"
#import "POP.h"

@interface KBPOPBasicAnimationViewController ()

@property(nonatomic,strong)UIView *textView;

@end

@implementation KBPOPBasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"POPBasicAnimation";
    
    self.view.backgroundColor=[UIColor redColor];
    
    self.textView=[[UIView alloc]initWithFrame:CGRectMake(0, 80, 100, 100)];
    self.textView.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:_textView];
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"随机运动" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(randMove) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *springButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [springButton setTitle:@"Spring" forState:UIControlStateNormal];
    [springButton addTarget:self action:@selector(popSpringAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:springButton];
    
    UIButton *rotationButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [rotationButton setTitle:@"旋转" forState:UIControlStateNormal];
    [rotationButton addTarget:self action:@selector(rotationClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rotationButton];
    
    UIButton *opactiyButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [opactiyButton setTitle:@"特明度设置" forState:UIControlStateNormal];
    [opactiyButton addTarget:self action:@selector(opacityClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:opactiyButton];
    
    
    
    
    [button makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@100);
        make.height.equalTo(@40);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(80);
    }];
    
    [springButton makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.centerX.equalTo(button);
        make.top.equalTo(button.bottom).offset(20);
    }];
    
    [rotationButton makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.centerX.equalTo(button);
        make.top.equalTo(springButton.bottom).offset(20);
    }];
    
    [opactiyButton makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.centerX.equalTo(button);
        make.top.equalTo(rotationButton.bottom).offset(20);
    }];

}




-(void)randMove{

    NSInteger height = CGRectGetHeight(self.view.bounds);
    NSInteger width = CGRectGetWidth(self.view.bounds);
    
    CGFloat centerX = arc4random() % width;
    CGFloat centerY = arc4random() % height;
    
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.duration = 0.4;
    [self.textView pop_addAnimation:anim forKey:@"centerAnimation"];
    

}


-(void)popSpringAnimation{


    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    
    NSInteger height = CGRectGetHeight(self.view.bounds);
    NSInteger width = CGRectGetWidth(self.view.bounds);
    CGFloat centerX = arc4random() % width;
    CGFloat centerY = arc4random() % height;
    
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    anim.springBounciness = 16;
    anim.springSpeed = 6;
    [self.textView pop_addAnimation:anim forKey:@"center"];
}


-(void)rotationClick:(UIButton *)sender{

    POPSpringAnimation *rotationAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    rotationAnimation.beginTime = CACurrentMediaTime() + 0.2;
    rotationAnimation.toValue = @(1.2);
    rotationAnimation.springBounciness = 10.f;
    rotationAnimation.springSpeed = 3;
    [self.textView .layer pop_addAnimation:rotationAnimation forKey:@"rotationAnim"];

}



-(void)opacityClick:(UIButton*)sender{

    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.5);
    [self.textView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
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
