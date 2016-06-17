//
//  paymentService.h
//  KBFuny
//
//  Created by jinlb on 15/5/18.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AlipayRechargeDTO <NSObject>
@property (copy,nonatomic) NSString *userId;
@property (strong,nonatomic) NSNumber *amount;//(分为单位的int
@property (assign,nonatomic) NSString *orderNo;//订单号，没有就不传
@end


@protocol AlipayRechargeResultDTO <NSObject>
@property(assign,nonatomic) NSNumber *status; //0为成功
@property(assign,nonatomic) NSNumber *fundId;//就是充值用得ID

@end

@protocol paymentService <NSObject>
/**
 *  获取支付宝充值 tradeID
 *
 *  @param userId 用户ID
 *  @param amt    充值金额
 *
 *  @return tradeID  用来交易用
 */
-(id<AlipayRechargeResultDTO>)alipayRecharge:(id<AlipayRechargeDTO>)dto;
@end

