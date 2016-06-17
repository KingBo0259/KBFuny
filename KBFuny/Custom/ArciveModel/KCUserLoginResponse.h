//
//  KCUserLoginResponse.h
//  kuaidihuoyun
//
//  Created by jinlb on 14/12/9.
//  Copyright (c) 2014年 banyanan. All rights reserved.
//

#import "KCAddressResponse.h"
#import <Foundation/Foundation.h>

@class KCUserLoginDataResponse;

@interface KCUserLoginResponse : NSObject<NSCoding>
@property (nonatomic,strong)KCUserLoginDataResponse *data;
@property (nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *deviceToken;
//单例
+(KCUserLoginResponse*)shareInstance;
@end

@interface KCUserLoginDataResponse : NSObject<NSCoding>
@property NSInteger deadLine;
@property (nonatomic,copy)NSString *money;
@property (nonatomic,copy)NSString *secretKey;
@property (nonatomic,copy)NSString *token;
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *uid;
@property (nonatomic,copy)NSString *icon;
@property (nonatomic,assign)NSInteger tempRegister;
@property (nonatomic,assign)NSInteger hasPassword;
@property (nonatomic,strong)KCAddressResponse *address;


@end