//
//  KBShoppingWindow.h
//  KBFuny
//
//  Created by jinlb on 16/7/22.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBShoppingCartDetailController.h"


@interface KBShoppingWindow : UIWindow

@property(weak,nonatomic) id<KBShoppingCartDetailDelegate>delegate;
+(instancetype)shareShoppingWindow;

-(void)show;
-(void)hide;
@end
