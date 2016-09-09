//
//  UIButton+KB.h
//  KBFuny
//  由于Category是无法添加属性的，因此用 associated
//  Created by jinlb on 16/9/9.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (KB)



/**
 *  用来存储自定义Tag
 *
 *  @param myTag 自定义Tag
 */
-(void)setMyTag:(id)myTag;
/**
 *  获取自定义Tag 数据
 */
-(id)getMyTag;
@end
