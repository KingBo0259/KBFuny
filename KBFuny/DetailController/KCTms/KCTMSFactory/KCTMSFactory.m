//
//  KCTMSFactory.m
//  KBFuny
//
//  Created by jinlb on 16/4/19.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KCTMSFactory.h"
#import <JSONModel/JSONHTTPClient.h>
#import <AFNetworking.h>

static id<KCTMSEncodeProtocol> _encode;//编码规则实例化
static id<KCTMSDecodeProtocol> _decode;//解码实体类

@implementation KCTMSFactory

#pragma 初始化编码器和解码器
+(void)initWithEncode:(id<KCTMSEncodeProtocol>)encode decode:(id<KCTMSDecodeProtocol>)decode{

    _encode=encode;
    _decode=decode;


}

#pragma mark -- Post
+(void)postWithURL:(NSString*)urlStr
               value:(JSONModel*)requestValue
                   success:(KCTMSSuccessBlock)success
                      fail:(KCTMSErrorBlock)error{
    
    [self postMulitWithURL:urlStr
                    params:@[requestValue]//若是空的参数则转化为“”
                   success:^(KCTMSRpcResponse *responseObject) {
        if (success) {
            responseObject.body=responseObject.body&&[responseObject isKindOfClass:[NSDictionary class]]?[responseObject.body allObjects][0]:nil;
            success(responseObject);
        }
        
    } fail:^(NSError *error1) {
        if(error){
            error(error1);
        }
        
    }];
}

/*
 *  无请求参数，直传人key 值
 * @url    请求路径
 * @responseClass 反回的对象数据 格式
 * @success 成功结果
 * @error   失败结果
 */

+(void)postNoRequstWithURL:(NSString*)urlStr
                    tmsKey:(NSString*)tmsKey
                   success:(KCTMSSuccessBlock )success
                      fail:(KCTMSErrorBlock )error{
    [self postMulitWithURL:urlStr
                    params:@[tmsKey]//若是空的参数则转化为“”
                   success:^(KCTMSRpcResponse *responseObject) {
                       if (success) {
                           responseObject.body=responseObject.body&&[responseObject isKindOfClass:[NSDictionary class]]?[responseObject.body allObjects][0]:nil;
                           success(responseObject);
                       }
                       
                   } fail:^(NSError *error1) {
                       if(error){
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

+(void)postMulitWithURL:(NSString*)urlStr
                 params:(NSArray*)params
           success:(KCTMSSuccessBlock)success
              fail:(KCTMSErrorBlock)error{
    
    //1、将请求参数 封装成tms指定的json组装格数

    NSString *bodyStr=[_encode encodeFromArray:params];//编码数据
    
    //A、JsonHttpClient request
    // [JSONHTTPClient requestHeaders] //可以设置requstHead 信息
//    [JSONHTTPClient postJSONFromURLWithString:urlStr bodyString:bodyStr completion:^(id json, JSONModelError *err) {
//        
//        id  tmsResponse= [_decode decodeToNativeFromServiceResponse:json];
//        if (err) {
//            
//            if (error) {
//                error(err);
//            }
//        }else{
//            if (success) {
//                success(tmsResponse);
//            }
//        }
//        
//        
//    }];
    
    
    
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval=15.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    request.HTTPBody=[bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    NSURLSessionDataTask *task= [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error1) {
        
        if (error1) {
            if (error) {
                error(error1);
            }
            return ;
        }
        
         id  tmsResponse= [_decode decodeToNativeFromServiceResponse:responseObject];
            if (success)
            {
                    success(tmsResponse);
            }
        
        
            }];
    //启动方法
    [task resume];
    
}







@end
