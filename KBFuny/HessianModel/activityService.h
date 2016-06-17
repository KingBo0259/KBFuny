//
//  activityService.h
//  KBFuny
//
//  Created by jinlb on 15/5/18.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RechargeDTO <NSObject>
@property(nonatomic,strong) NSNumber *rechargeAmount;
@property(nonatomic,strong) NSNumber *couponAmount;
@property(nonatomic,copy) NSString* url;
@end

@protocol RechargeActivityDTO <NSObject>
@property (nonatomic,strong) NSMutableArray *rechargeList;
@end

@protocol activityService <NSObject>
-(id<RechargeActivityDTO>)getRechargeActivity;
@end
