//
//  KCCityListResponse.h
//  KBFuny
//
//  Created by jinlb on 16/4/19.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "KCCityResponse.h"
@interface KCCityListResponse : JSONModel
@property(nonatomic,assign)NSInteger total;
@property(nonatomic,strong,nullable) NSArray<KCCityResponse> *items;
@property(nonatomic,copy,nullable) NSString<Optional>*name;//Optional 这里配置可为空 （否则银色为空）


//test   去掉无关属性
@property(nonatomic,strong,nullable) NSArray<Optional,KCCityResponse> *items1;
@property(nonatomic,strong,nullable) NSArray<KCCityResponse> *items2;


@end
