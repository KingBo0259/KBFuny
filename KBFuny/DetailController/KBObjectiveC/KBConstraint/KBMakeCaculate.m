//
//  KBConstraint.m
//  KBFuny
//
//  Created by jinlb on 2017/2/24.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import "KBMakeCaculate.h"

@implementation KBMakeCaculate

/**
 add
 */
-(KBMakeCaculate *(^)(NSInteger))add{
    return ^ KBMakeCaculate *(NSInteger value){
        _reuslt+=value;
        return self;
    };
}



/**
 min
 */
-(KBMakeCaculate *(^)(NSInteger))min{
    return ^ KBMakeCaculate *(NSInteger value){
        _reuslt -=value;
        
        return self;
    };

}
@end
