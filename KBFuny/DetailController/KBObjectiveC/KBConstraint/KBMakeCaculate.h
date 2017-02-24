//
//  KBConstraint.h
//  KBFuny
//  链式编程思想 测试
//  Created by jinlb on 2017/2/24.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBMakeCaculate : NSObject



/**
 add
 */
-(KBConstraint *(^)(NSInteger))add;

/**
 add
 */
-(KBConstraint *(^)(NSInteger))min;

@end
