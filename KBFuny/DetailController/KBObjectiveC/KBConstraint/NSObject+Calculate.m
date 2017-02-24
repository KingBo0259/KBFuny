//
//  NSObject+Calculate.m
//  KBFuny
//
//  Created by jinlb on 2017/2/24.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import "NSObject+Calculate.h"

@implementation NSObject (Calculate)

/**
 计算
 
 @param calculate 计算blokc
 @return 返回值
 */
-(NSInteger)makeCalculate:(void(^)(KBMakeCaculate* maker))calculate{
    //方法一
    KBMakeCaculate * maker = [KBMakeCaculate new];
    calculate(maker);
    
    return maker.reuslt;
//    //方法二
//    KBMakeCaculateManager *manager = [KBMakeCaculateManager new];
//    [manager makeCalculate:calculate];
//    
//    return manager.maker.reuslt;
}
@end
