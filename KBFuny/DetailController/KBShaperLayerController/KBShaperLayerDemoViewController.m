//
//  KBShaperLayerDemoViewController.m
//  KBFuny
//
//  Created by jinlb on 16/7/13.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBShaperLayerDemoViewController.h"
#import "KBCALayerFactory.h"

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
    

    
}

-(void)click:(id)sender{

    NSLog(@"click");
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
