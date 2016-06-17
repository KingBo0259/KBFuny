//
//  KCTMSBaseService.m
//  KBFuny
//
//  Created by jinlb on 16/4/20.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KCTMSBaseService.h"
#import "KCTMSArchive.h"
#import "KCTMSUnarchive.h"

static  NSString * KCTMSServiceURL;

@implementation KCTMSBaseService

+(void)initialize{

    KCTMSServiceURL=@"http://192.168.6.81:8080/odin/servlet/gate";
    [KCTMSFactory initWithEncode:[KCTMSArchive new] decode:[KCTMSUnarchive new]];

}

-(void)postWithRequestModel:(JSONModel*)requestValue
              success:(KCTMSSuccessBlock)success
                 fail:(KCTMSErrorBlock)error{
    
    [KCTMSFactory postWithURL:KCTMSServiceURL
                           value:requestValue
                         success:^(KCTMSRpcResponse *responseObject) {
                             //1、 可以处理异常公共的 异常处理
                             
                             //2、回调
                             
                             if (success) {
                                 success(responseObject);
                             }
                             
                             
                         } fail:^(NSError *error1) {
                             //处理公共的异常处理
                             if (error) {
                                 error(error1);
                             }
                             
                         }
                            ];
}


/*
 *  无请求参数，直传人key 值; 只反回一个结果
 * @url    请求路径
 * @tmsKey  serviceKey
 * @success 成功结果
 * @error   失败结果
 */
-(void)postNoRequstWithTmsKey:(NSString*)tmsKey
                   success:(KCTMSSuccessBlock )success
                      fail:(KCTMSErrorBlock )error{

    [KCTMSFactory postNoRequstWithURL:KCTMSServiceURL tmsKey:tmsKey success:^(KCTMSRpcResponse *responseObject) {
        //1、 可以处理异常公共的 异常处理
        
        //2、回调
        
        if (success) {
            success(responseObject);
        }

        
    } fail:^(NSError *error1) {
        
        //处理公共的异常处理
        if (error) {
            error(error1);
        }
        

    }];

}


/*
 * @url             请求的URL 路径
 * @params          多个请求参数形式如：｛key1:JSONModel1,key2:JSONModel2｝
 * @responseMap     json 反回映射到本地对象的映射表 ：｛key1:[JSONModel1 class],key2:[JSONModel2 class]｝
 * @success         成功回调
 * @fail            失败回调
 */

-(void)postMulitWithParams:(NSArray*)params
                success:(KCTMSSuccessBlock)success
                   fail:(KCTMSErrorBlock)error{
    [KCTMSFactory   postMulitWithURL:KCTMSServiceURL
                              params:params
                          success:^(KCTMSRpcResponse *responseObject) {
        //1、 可以处理异常公共的 异常处理
        
        //2、回调
        
        if (success) {
            success(responseObject);
        }
        
    } fail:^(NSError *error1) {
        //处理公共的异常处理
        if (error) {
            error(error1);
        }
        
    }];

}


@end
