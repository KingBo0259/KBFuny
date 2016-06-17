//
//  UserService.m
//  KBFuny
//
//  Created by jinlb on 16/4/19.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KCTMSRegionService.h"
#import <JSONModel/JSONModel.h>
#import "KCCityListResponse.h"
#import "KCTMSFactory.h"
#import "KCTMSRpcResponse.h"
#import "KCTMSCityRequest.h"

//声明 static 则说明是局部常量
static NSString  * const TMSRegionServiceUrl=@"http://192.168.6.81:8080/odin/servlet/gate";

@implementation KCTMSRegionService

+(void)initialize{
    NSLog(@"initalize");


}
///获取城市信息
-(void)getProviceListWithSuccess:(KCTMSSuccessBlock)kcSuccess
                       error:(KCTMSErrorBlock)kcError{
    [self postNoRequstWithTmsKey:@"TMSRegionAPI.getProvinces" success:kcSuccess fail:kcError];
}

-(void)getProviceWithCityId:(NSString*)cityId
                        success:(KCTMSSuccessBlock)kcSuccess
                      error:(KCTMSErrorBlock)kcError{

    KCTMSCityRequest *cityRequst=[KCTMSCityRequest new];
    cityRequst.provinceId=cityId;
    [self postWithRequestModel:cityRequst
                 success:kcSuccess fail:kcError];
    
}

///多个接口测试
-(void)mulitRquestTestWithCityId:(NSString*)cityId
                         success:(KCTMSSuccessBlock)kcSuccess
                           error:(KCTMSErrorBlock)kcError{
    
    KCTMSCityRequest *cityRequst=[KCTMSCityRequest new];
    cityRequst.provinceId=cityId;

    NSArray *request=@[@"TMSRegionAPI.getProvinces",cityRequst];
    [self postMulitWithParams:request
                      success:kcSuccess fail:kcError];
    
    

}
@end
