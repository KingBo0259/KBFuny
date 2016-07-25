//
//  KBShoppingCartDetailController.m
//  KBFuny
//
//  Created by jinlb on 16/7/22.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBShoppingCartDetailController.h"

@interface KBShoppingCartDetailController()

@property(weak,nonatomic)UIView *bootView;

@end

@implementation KBShoppingCartDetailController




-(void)viewDidLoad{

    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor clearColor];
    
    [self initUI];
    
    
    
}


-(void)initUI{

    
    UIView *backgroundView=[UIView new];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0.3;
    backgroundView.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *panGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(panClick:)];
    [backgroundView addGestureRecognizer:panGesture];
    [self.view addSubview:backgroundView];
    
    
    
    UIView *bootView=[UIView new];
    bootView.backgroundColor=[UIColor yellowColor];
    self.bootView=bootView;
    bootView.frame=CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), 250.0f);

    [self.view addSubview:bootView];

    [backgroundView makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
    
    
    
}

-(void)showAnimationWithShowFlag:(BOOL)isShow completion:(void (^ __nullable)(BOOL finished))completion{

    [UIView animateWithDuration:0.3 animations:^{
        CGFloat height=CGRectGetHeight(_bootView.frame);
        CGFloat top=isShow?(CGRectGetHeight(self.view.frame)-height):self.view.frame.size.height;
        _bootView.frame=CGRectMake(0, top, CGRectGetWidth(self.view.frame), height);
        
    } completion:completion];
   
}

-(void)showAnimation{

    [self showAnimationWithShowFlag:YES completion:^(BOOL finished) {
        
    }];
    

}

-(void)hidenAnimation{
    [self showAnimationWithShowFlag:NO completion:^(BOOL finished) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(shoppingCartDetailHidden)]) {
            [self.delegate shoppingCartDetailHidden];
        }
    }];

}

-(void)panClick:(id)sender{
    [self hidenAnimation];

}
@end
