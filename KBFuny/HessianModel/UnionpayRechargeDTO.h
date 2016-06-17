//
//  UnionpayRechargeDTO.h
//  KBFuny
//
//  Created by jinlb on 15/5/18.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UnionpayRechargeDTO <NSObject>
@property (assign,nonatomic) NSNumber *amt;
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *userId;
@end
