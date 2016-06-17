//
//  KCTMSFactory.h
//  KBFuny
//
//  Created by jinlb on 16/4/19.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "KCTMSRpcResponse.h"
#import "KCTMSEncodeProtocol.h"
#import "KCTMSDecodeProtocol.h"


typedef void(^KCTMSSuccessBlock)(KCTMSRpcResponse *responseObject);

typedef void(^KCTMSErrorBlock)(NSError*error);

@interface KCTMSFactory : NSObject

/*
 * 设置编码器 和解码器
 * @encode  编码器，用来将本地对象分解成  json
 * @decode  解码器，用来将服务器数据  解码为本地对象
 */
+(void)initWithEncode:(id<KCTMSEncodeProtocol>)encode decode:(id<KCTMSDecodeProtocol>)decode;


/*
 * 单个对象请求。 只反回一个响应结果。
 * @url    请求路径
 * @value requst对象值
 * @success 成功结果
 * @error   失败结果
 */
+(void)postWithURL:(NSString*)urlStr
             value:( JSONModel* )requestValue
           success:(KCTMSSuccessBlock )success
              fail:(KCTMSErrorBlock )error;

/*
 *  无请求参数，直传人key 值; 只反回一个结果
 * @url    请求路径
 * @tmsKey  serviceKey
 * @success 成功结果
 * @error   失败结果
 */
+(void)postNoRequstWithURL:(NSString*)urlStr
                     tmsKey:(NSString*)tmsKey
                   success:(KCTMSSuccessBlock )success
                      fail:(KCTMSErrorBlock )error;


/*
 *  万能接口，可以解决所有请求问题
 * @url             请求的URL 路径
 * @params          多个请求参数形式如：｛key1:JSONModel1,key2:JSONModel2｝
 * @responseMap     json 反回映射到本地对象的映射表 ：｛key1:[JSONModel1 class],key2:[JSONModel2 class]｝
 * @success         成功回调
 * @fail            失败回调
 */

+(void)postMulitWithURL:(NSString*)urlStr
                 params:(NSArray*)params
                success:(KCTMSSuccessBlock)success
                   fail:(KCTMSErrorBlock)error;

@end
