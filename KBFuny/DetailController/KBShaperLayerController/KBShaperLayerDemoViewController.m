//
//  KBShaperLayerDemoViewController.m
//  KBFuny
//
//  Created by jinlb on 16/7/13.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBShaperLayerDemoViewController.h"
#import "KBCALayerFactory.h"
#import "KBFadeString.h"

@interface KBShaperLayerDemoViewController ()

@end

@implementation KBShaperLayerDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    
    //边框裁剪效果实现
    UIView *cutView=[[UIView alloc]init];
    cutView.backgroundColor=[UIColor blueColor];
    cutView.frame=CGRectMake(30, 88, 100, 100);
    
    
    
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"樱花树2"]];
    [cutView addSubview:imageView];
    imageView.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *recoginizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    [imageView addGestureRecognizer:recoginizer];
    
    
    cutView.layer.mask=[KBCALayerFactory createShaperWithView:cutView];

    [self.view addSubview:cutView];
    
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cutView);
    }];
    
    
    UILabel *descripLabel=[UILabel new];
    descripLabel.textColor=[UIColor blackColor];
    descripLabel.text=@"使用CAShaperLayer构建图层，然后View 的layer.mask 属性用来进行裁剪形状;";
    descripLabel.numberOfLines=0;
    [self.view addSubview:descripLabel];
    [descripLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.bottom.equalTo(cutView);
        make.left.equalTo(cutView.right).offset(5);
        make.right.equalTo(self.view).offset(-5);
    }];
    

    
    //圆形进度条
    
    UIView *criclProcessView=[[UIView alloc]init];
    criclProcessView.backgroundColor = [UIColor yellowColor];
    criclProcessView.frame=CGRectMake(30, 200, 30, 30);
    
   [criclProcessView.layer addSublayer:   [KBCALayerFactory circlProgressLayerWithWidth:criclProcessView.frame.size.width]];
    
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*2];
    anima3.duration = 1.25f;
    anima3.repeatCount = MAXFLOAT;
    anima3.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [criclProcessView.layer addAnimation:anima3 forKey:@"rotaionAniamtion"];
    
    [self.view addSubview:criclProcessView];
    

    
    descripLabel=[UILabel new];
    descripLabel.textColor=[UIColor blackColor];
    descripLabel.text=@"使用了CAShapeLayer的strokeStart和strokeEnd属性 来进行绘制";
    descripLabel.numberOfLines=0;
    [self.view addSubview:descripLabel];
    [descripLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(criclProcessView);
        make.left.equalTo(criclProcessView.right).offset(5);
        make.right.equalTo(self.view).offset(-5);
    }];
    
    
    
    //自动布局水平抗压设置
    UILabel *address = [[UILabel alloc] init];
    [self.view addSubview:address];
    address.text = @"地址:";
    address.textColor=[UIColor yellowColor];
    address.font=[UIFont systemFontOfSize:18.0f];
    address.backgroundColor = [UIColor blueColor];
    
    //添加水平抗压缩功能。否则Label会被 UItextFiel 挤压
    [address setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(criclProcessView.bottom).offset(20);
        make.left.equalTo(@20);
    }];
    
    UITextField *addressTextField = [[UITextField alloc] init];
    [self.view addSubview:addressTextField];
    addressTextField.returnKeyType = UIReturnKeyDone;
    addressTextField.font = [UIFont systemFontOfSize:15];
    addressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    addressTextField.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    addressTextField.layer.borderColor =  [[UIColor redColor] CGColor];
    addressTextField.layer.cornerRadius = 3;
    addressTextField.placeholder=@"输入数据";
    addressTextField.text=@"Label添加水平抗压缩功能。否则会被UItextFiel挤压";
    [addressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(address);
        make.centerY.equalTo(address);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.left.equalTo(address.mas_right).offset(10);
    }];
    
    
    KBFadeString * fadeString = [[KBFadeString alloc] initWithFrame:CGRectMake(60, 80, 300, 40)];
    fadeString.text = @"金凌波创建的";
    [self.view addSubview:fadeString];
    
//    //执行动画
//    [fadeString fadeRight];
    
}

-(void)click:(id)sender{

    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"点我干什么" message:@"再点一次呗" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancel];
    
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
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
