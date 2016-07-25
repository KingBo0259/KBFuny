//
//  KBShoppingWindow.m
//  KBFuny
//
//  Created by jinlb on 16/7/22.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBShoppingWindow.h"

static KBShoppingWindow *shoppingWindow=nil;

@interface KBShoppingWindow()<KBShoppingCartDetailDelegate>{
}

@end

@implementation KBShoppingWindow


+(instancetype)shareShoppingWindow{
    static dispatch_once_t onceToken;


    dispatch_once(&onceToken , ^{
        shoppingWindow=[[KBShoppingWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        shoppingWindow.windowLevel=UIWindowLevelNormal;
        
        KBShoppingCartDetailController *controller=[KBShoppingCartDetailController new];
        controller.delegate=shoppingWindow;
        shoppingWindow.rootViewController=controller;
    });
    
    
    return shoppingWindow;
    
}

-(void)show{
    [self makeKeyAndVisible];
    [((KBShoppingCartDetailController*)shoppingWindow.rootViewController ) showAnimation];

}
-(void)hide{
    [self setHidden:YES];
}


-(void)shoppingCartDetailHidden{

    if (self.delegate&&[self.delegate respondsToSelector:@selector(shoppingCartDetailHidden)]    ) {
        [self.delegate shoppingCartDetailHidden];
    }
    [self hide];

}
@end
