//
//  UIButton+KB.m
//  KBFuny
//  这里只用来测试  category 类别工作
//  使用associatedobject 来添加系统UIButton 控件
//  Created by jinlb on 16/9/9.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "UIButton+KB.h"
#import <objc/runtime.h>

static char myTagKey;

@implementation UIButton (KB)
-(void)setMyTag:(id)myTag{
    //通过associate 运行时来替换属性的功能
    objc_setAssociatedObject(self, &myTagKey, myTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

-(id)getMyTag{
   return  objc_getAssociatedObject(self, &myTagKey);
}
@end
