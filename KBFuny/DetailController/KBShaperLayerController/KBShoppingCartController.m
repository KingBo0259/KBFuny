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

@property(weak,nonatomic)UIView *myView;


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
    
    
   UIButton * menuButton=[UIButton new];
    [menuButton setTitle:@"UIMenuContoller" forState:UIControlStateNormal];
    [menuButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(menuController:) forControlEvents:UIControlEventTouchUpInside];
    _myView=menuButton;
    [self.view addSubview:menuButton];
    
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
    
    [menuButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(fangdaButton.bottom).offset(10);
        make.height.equalTo(fangdaButton);
    }];

    
}

#pragma mark  - menu
-(void)menuController:(UIButton*)button{
    UIMenuItem *flag = [[UIMenuItem alloc] initWithTitle:@"delete"action:@selector(flag:)];
    UIMenuItem *approve = [[UIMenuItem alloc] initWithTitle:@"copy"action:@selector(approve:)];
    UIMenuItem *deny = [[UIMenuItem alloc] initWithTitle:@"cancel"action:@selector(deny:)];
    
    UIMenuController *menu=[UIMenuController sharedMenuController];
    [menu setMenuItems:@[flag,approve,deny]];
    [menu setTargetRect:CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.size.width, 30) inView:self.view];
    [menu setMenuVisible:YES animated:YES];
}


-(void)flag:(id)sender{

}

-(void)approve:(id)sender{

}

-(void)deny:(id)sender{

}
//必须要有，如果要UIMenuController显示
-(BOOL)canBecomeFirstResponder{

    return YES;
}

//监听自己的定义事件，是 return YES；  否 return NO 即移除系统；
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{

    
    if (action==@selector(flag:)||action==@selector(approve:)||action==@selector(deny:)) {
        return YES;
    }
    return NO;
}


#pragma mark - 效果动画
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
