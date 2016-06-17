//
//  KCTMSDecodeProtocol.h
//  KBFuny
//
//  Created by jinlb on 16/4/22.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KCTMSDecodeProtocol <NSObject>

@required
///将服务器返回数据，解析到本地对象
-(id)decodeToNativeFromServiceResponse:(id)servicereResponse;
@end
