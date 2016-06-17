//
//  UnionpayService.h
//  KBFuny
//
//  Created by jinlb on 15/5/18.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnionpayRechargeDTO.h"
#import "UnionpayOrderTransDTO.h"

@protocol UnionpayService <NSObject>
-(id<UnionpayOrderTransDTO>)recharge:(id<UnionpayRechargeDTO>)recharge;

@end
