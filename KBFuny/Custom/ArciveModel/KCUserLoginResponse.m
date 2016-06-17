//
//  KCUserLoginResponse.m
//  kuaidihuoyun
//
//  Created by jinlb on 14/12/9.
//  Copyright (c) 2014年 banyanan. All rights reserved.
//

#import "KCUserLoginResponse.h"
#import <objc/runtime.h>

#define kDateKey     @"DataKey"
#define KUserIDKey   @"UserIDKey"

@implementation KCUserLoginResponse

+(KCUserLoginResponse*)shareInstance
{
    static KCUserLoginResponse *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    
    return sharedAccountManagerInstance;
    
    
}



-(id)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super init]) {
        self.userId=[aDecoder decodeObjectForKey:KUserIDKey];
        self.data=[aDecoder decodeObjectForKey:kDateKey];
    }
    
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:_data forKey:kDateKey];
    [aCoder encodeObject:_userId forKey:KUserIDKey];
}


@end

#define kDeadLineKey @"DeadLineKey"
#define kMoneyKey       @"MoneyKey"
#define kSecretKey   @"SecretKey"
#define kTokenKey       @"TokenKey"
#define kUserNameKey    @"UserNameKey"
#define kUidKey         @"UidKey"
#define kICONKey        @"IconKey"
#define kTempRegisterKey @"TemoRegisterKey"
#define kHasPasswordKey  @"HasPasswordKey"
#define kAddressKey      @"AddressKey"

@implementation KCUserLoginDataResponse
-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        Class class=[self class];
        while (class !=[NSObject class]) {
            
            unsigned int count = 0;
            //获取类中所有成员变量名
            Ivar *ivar = class_copyIvarList([self class], &count);
            for (int i = 0; i<count; i++) {
                Ivar iva = ivar[i];
                const char *name = ivar_getName(iva);
                NSString *strName = [NSString stringWithUTF8String:name];
                //进行解档取值
                id value = [aDecoder decodeObjectForKey:strName];
                //利用KVC对属性赋值
                [self setValue:value forKey:strName];
            }
            free(ivar);
            
            class=[class superclass];
        }
        
//        
//        self.deadLine=[aDecoder  decodeIntegerForKey:kDeadLineKey];
//        self.money=[aDecoder decodeObjectForKey:kMoneyKey];
//        self.secretKey=[aDecoder decodeObjectForKey:kSecretKey];
//        self.token=[aDecoder decodeObjectForKey:kTokenKey];
//        self.userName=[aDecoder decodeObjectForKey:kUserNameKey];
//        self.uid=[aDecoder decodeObjectForKey:kUidKey];
//        self.icon=[aDecoder decodeObjectForKey:kICONKey];
//        self.tempRegister=[aDecoder decodeIntegerForKey:kTempRegisterKey];
//        self.hasPassword=[aDecoder decodeIntegerForKey:kHasPasswordKey];
//        self.address=[aDecoder decodeObjectForKey:kAddressKey];
    }
    
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    
    unsigned int count;
    Ivar *ivar = class_copyIvarList([self class], &count);
    for (int i=0; i<count; i++) {
        Ivar iv = ivar[i];
        const char *name = ivar_getName(iv);
        NSString *strName = [NSString stringWithUTF8String:name];
        //利用KVC取值
        id value = [self valueForKey:strName];
        [aCoder encodeObject:value forKey:strName];
    }
    free(ivar);
//    [aCoder encodeInteger:_deadLine forKey:kDeadLineKey];
//    [aCoder encodeObject:_money forKey:kMoneyKey];
//    [aCoder encodeObject:_secretKey forKey:kSecretKey];
//    [aCoder encodeObject:_token     forKey:kTokenKey];
//    [aCoder encodeObject:_userName forKey:kUserNameKey];
//    [aCoder encodeObject:_uid forKey:kUidKey];
//    [aCoder encodeObject:_icon forKey:kICONKey];
//    [aCoder encodeInteger:_tempRegister forKey:kTempRegisterKey];
//    [aCoder encodeInteger:_hasPassword forKey:kHasPasswordKey];
//    [aCoder encodeObject:_address forKey:kAddressKey];
//    [aCoder encodeInteger:_tempRegister forKey:kTempRegisterKey];

}




@end