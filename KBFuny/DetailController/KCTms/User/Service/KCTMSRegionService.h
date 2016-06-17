//
//  UserService.h
//  KBFuny
//
//  Created by jinlb on 16/4/19.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KCTMSBaseService.h"

@interface KCTMSRegionService : KCTMSBaseService
///获取城市
-(void)getProviceListWithSuccess:(KCTMSSuccessBlock)success error:(KCTMSErrorBlock)error;

///获取单个城市信息
-(void)getProviceWithCityId:(NSString*)cityId success:(KCTMSSuccessBlock)kcSuccess
                      error:(KCTMSErrorBlock)kcError;

///多个借口测试
-(void)mulitRquestTestWithCityId:(NSString*)cityId
                         success:(KCTMSSuccessBlock)kcSuccess
                           error:(KCTMSErrorBlock)kcError;

@end
