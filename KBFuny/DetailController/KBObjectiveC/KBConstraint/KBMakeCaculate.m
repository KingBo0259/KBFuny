//
//  KBConstraint.m
//  KBFuny
//
//  Created by jinlb on 2017/2/24.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import "KBConstraint.h"

@implementation KBMakeCaculate

/**
 add
 */
-(KBMakeCaculate *(^)(NSInteger))add{
    return ^(NSInteger value){
        
        return self;
    };
}
@end
