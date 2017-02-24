//
//  NSObject+Calculate.h
//  KBFuny
//
//  Created by jinlb on 2017/2/24.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBMakeCaculateManager.h"
@interface NSObject (Calculate)

/**
 计算

 @param calculate 计算blokc
 @return 返回值
 */
-(NSInteger)makeCalculate:(void(^)(KBMakeCaculate*maker))calculate;
@end
