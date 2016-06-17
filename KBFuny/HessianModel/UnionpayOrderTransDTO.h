//
//  UnionpayOrderTransDTO.h
//  KBFuny
//
//  Created by jinlb on 15/5/18.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UnionpayOrderTransDTO <NSObject>

@property(assign,nonatomic)NSNumber *fundId;
@property (copy,nonatomic) NSString *chrCode;
@property (copy,nonatomic) NSString *transId;
@property (copy,nonatomic) NSString *merSign;
@end
