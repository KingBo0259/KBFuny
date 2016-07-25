//
//  KBShoppingCartDetailController.h
//  KBFuny
//
//  Created by jinlb on 16/7/22.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  KBShoppingCartDetailDelegate <NSObject>

-(void)shoppingCartDetailHidden;
@end


@interface KBShoppingCartDetailController : UIViewController

@property(weak,nonatomic) id<KBShoppingCartDetailDelegate> delegate;

-(void)showAnimation;

@end


