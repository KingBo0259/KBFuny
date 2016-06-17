//
//  KCTMSArchive.m
//  KBFuny
//
//  Created by jinlb on 16/4/21.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KCTMSArchive.h"
#import "JSONModel.h"
static NSMutableDictionary *_tmsRequestMap;//出参映射表

@implementation KCTMSArchive
+(void)initialize{

    if (self==[KCTMSArchive class]) {
        _tmsRequestMap=[[NSMutableDictionary alloc]init];
    }
}

+(void)setTmsKey:(NSString *)key forRequstModel:(Class)request{
    [_tmsRequestMap setObject:key forKey:NSStringFromClass(request)];

}

+(void)setTmsKey:(NSString*)key
 forRequstString:(NSString*)request{
    [_tmsRequestMap setObject:key forKey:request];

}


///将请求对象 编码成字符串
-(id)encodeFromArray:(NSArray*)request{

    __block NSMutableString *mutbaleStr=[[NSMutableString alloc]init];
    
    [request enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *value=nil,*tmsKey;
        if (obj&&[obj isKindOfClass:[JSONModel class]] ) {
            value=[((JSONModel*)obj) toJSONString];
            tmsKey=[_tmsRequestMap objectForKey: NSStringFromClass([obj class])];
            
        }else{
            value=@"{}";
            tmsKey=obj;
        }
        NSString*tempStr=[NSString stringWithFormat:@"%@=%@&",tmsKey,value];
        [mutbaleStr appendString:tempStr];
        
    }];
    
    //最后一步去掉‘&‘分隔符
    return [mutbaleStr substringToIndex:mutbaleStr.length-1];


}

@end
