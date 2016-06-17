//
//  KCTMSBaseService.h
//  KBFuny
//
//  Created by jinlb on 16/4/20.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCTMSFactory.h"

@interface KCTMSBaseService : NSObject
/*
 * @requestValue  上行参数的对象
 * @success         成功回调
 * @fail            失败回调
 */
-(void)postWithRequestModel:(JSONModel*)requestValue
              success:(KCTMSSuccessBlock)success
                 fail:(KCTMSErrorBlock)error;

/*
 * @url             请求的URL 路径
 * @params          多个请求参数形式。当然这里也可以直接传 key值：@[JSONModel1,JSONModel2，key1，key2...]，
 *                  当传key时 说明上行参数为空。不进行数据上行
 * @success         成功回调
 * @fail            失败回调
 */

-(void)postMulitWithParams:(NSArray*)params
                success:(KCTMSSuccessBlock)success
                   fail:(KCTMSErrorBlock)error;

/*
 *  无请求参数，直传人key 值; 只反回一个结果
 * @url    请求路径
 * @tmsKey  serviceKey
 * @success 成功结果
 * @error   失败结果
 */
-(void)postNoRequstWithTmsKey:(NSString*)tmsKey
                   success:(KCTMSSuccessBlock )success
                      fail:(KCTMSErrorBlock )error;

@end
