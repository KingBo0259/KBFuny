//
//  KCTMSUnarchive.m
//  KBFuny
//
//  Created by jinlb on 16/4/21.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KCTMSUnarchive.h"
#import <JSONModel/JSONModel.h>
#import "KCTMSRpcResponse.h"

static NSMutableDictionary *_tmsResponseMap;//出参映射表
@implementation KCTMSUnarchive

+(void)initialize{

    if (self==[KCTMSUnarchive class]) {
        _tmsResponseMap=[[NSMutableDictionary alloc]init];
    }

}


+(NSMutableDictionary*)getTmsResponseMap{

    return _tmsResponseMap;
}

///设置出参映射表
+(void)setResposneClass:(Class)reponseClass forTmsKey:(NSString*)key{

    [_tmsResponseMap setObject:NSStringFromClass(reponseClass) forKey:key];
}

+(void)setResposneString:(NSString*)reponseString forTmsKey:(NSString*)key{
    [_tmsResponseMap setObject:reponseString forKey:key];

}

#pragma mark DecodeProtocol
-(id)decodeToNativeFromServiceResponse:(id)servicereResponse{
//    NSString *html = servicereResponse;
//    //转为NSDiction
//    NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dict=servicereResponse;
    
    //一级分离出  status 、message  、yij
    NSInteger status= [dict[@"status"] integerValue];
    NSString *message= dict[@"message"];
    
    __block KCTMSRpcResponse *tmsResponse=[[KCTMSRpcResponse alloc]init];
    [tmsResponse setStatus:status];
    [tmsResponse setMessage:message];
    
    //获取json 对象结构数据
    NSDictionary *body=dict[@"body"];
    
    
    
    //将json  结构转化为 KCTMSRpcseponse 对象
    NSDictionary *responseBody=[self decodeRpcResponeFromTMSJson:body ];
    
    [tmsResponse setBody:responseBody];
    return tmsResponse;
}

#pragma mark - decode
/*
 * 将 TMSjson 对象映射成  本地对象
 * @body  这里是字典，因为已经将json 转为字典了
 * @map   key  和本地对象的映射关系
 */
-(NSDictionary*)decodeRpcResponeFromTMSJson:(NSDictionary*)body{
    
    if(![body isKindOfClass:[NSDictionary class]])return body;
    if(!body||body.count==0)return nil;
    __block NSMutableDictionary* resultDic=[[NSMutableDictionary alloc]initWithCapacity:body.count];
    //反回多个结果集
    [body enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        // 整整的数据，单个请求数据只有一级目录结构
        NSString *bodyJson= obj;
        NSError *error;
        
        NSString* classString= [_tmsResponseMap objectForKey:key];
        id class= NSClassFromString(classString);
        id response=[[class alloc] initWithString:bodyJson error:&error];
        [resultDic setValue:response forKey:key];
        
    }];
    return resultDic;
}

@end
