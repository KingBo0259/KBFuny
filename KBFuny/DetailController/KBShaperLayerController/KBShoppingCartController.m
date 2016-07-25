//
//  KBShoppingCartController.m
//  KBFuny
//
//  Created by jinlb on 16/7/22.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBShoppingCartController.h"
#import "KBShoppingWindow.h"

static const  NSTimeInterval  durationTime=0.2f;
@interface KBShoppingCartController ()<KBShoppingCartDetailDelegate>{

}


@end

@implementation KBShoppingCartController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"购物车效果";
    self.view.backgroundColor=[UIColor whiteColor];

    UIButton *shuoxiaoButton=[UIButton new];
    [shuoxiaoButton setTitle:@"缩小页面" forState:UIControlStateNormal];
    [shuoxiaoButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [shuoxiaoButton addTarget:self action:@selector(shrunkView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shuoxiaoButton];
    
    UIButton *fangdaButton=[UIButton new];
    [fangdaButton setTitle:@"恢复页面" forState:UIControlStateNormal];
    [fangdaButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [fangdaButton addTarget:self action:@selector(blowUpView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fangdaButton];
    
    
    [shuoxiaoButton makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        make.top.equalTo(@80);
        make.height.equalTo(@60);
        
    }];
    
    [fangdaButton makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        make.top.equalTo(shuoxiaoButton.bottom).offset(10);
        make.height.equalTo(shuoxiaoButton);
        
    }];

    
}

/**
 *  缩小试图
 */
-(void)shrunkView{
    
    
    
    //自身缩小
    [UIView animateWithDuration:durationTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        CATransform3D perspective=CATransform3DIdentity;//透视效果  结构体用来描述效果
        perspective.m34=-1.0/500.0;
        

        perspective=CATransform3DScale(perspective, 0.9, 0.9,1.0);
        perspective=CATransform3DRotate(perspective, M_PI_4/4, 1, 0, 0);
        self.navigationController.view.layer.transform=perspective;
        
        
        
        
    } completion:^(BOOL finished) {
        
        
        [UIView animateWithDuration:durationTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            CATransform3D perspective=CATransform3DIdentity;//透视效果  结构体用来描述效果
            perspective.m34=-1.0/500.0;
            
            perspective=CATransform3DScale(perspective, 0.9, 0.9,1.0);
            perspective=CATransform3DRotate(perspective, 0, 1, 0, 0);
            self.navigationController.view.layer.transform=perspective;

            
        } completion:nil];
        
        
    }];
    
    //试图弹出
    KBShoppingWindow *shopperWindow=[KBShoppingWindow shareShoppingWindow];
    shopperWindow.delegate=self;
    [shopperWindow show];
    

}

/**
 *  放大恢复
 */
-(void)blowUpView{
    
    self.navigationController.view.layer.anchorPoint=CGPointMake(0.5, 0.5);

    [UIView animateWithDuration:durationTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        CATransform3D perspective=CATransform3DIdentity;//透视效果  结构体用来描述效果
        perspective.m34=-1.0/500.0;
        
        perspective=CATransform3DScale(perspective, 0.9, 0.9,1.0);
        perspective=CATransform3DRotate(perspective, M_PI_4/4, 1, 0, 0);
        self.navigationController.view.layer.transform=perspective;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:durationTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        CATransform3D perspective=CATransform3DIdentity;//透视效果  结构体用来描述效果
        perspective.m34=-1.0/500.0;
        
        perspective=CATransform3DScale(perspective, 1.0, 1.0,1.0);
        perspective=CATransform3DRotate(perspective, 0, 1, 0, 0);
        self.navigationController.view.layer.transform=perspective;
        } completion:nil];



        
    }];

}

#pragma KBShoppingCartDetailDelegate 
-(void)shoppingCartDetailHidden{

    //恢复图像
    [self blowUpView];

}
@end
