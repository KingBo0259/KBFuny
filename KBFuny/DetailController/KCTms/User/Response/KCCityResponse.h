//
//  KCCity.h
//  KBFuny
//
//  Created by jinlb on 16/4/19.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

//被其它引用时，需要定义协议
@protocol KCCityResponse <NSObject>


@end

@interface KCCityResponse: JSONModel

@property(nonatomic,assign)NSInteger id;
@property(nonatomic,assign)NSInteger parentId;
@property(nonatomic,copy) NSString*name;
@property(nonatomic,copy) NSString*sort;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,copy) NSString*nameFL;
@property(nonatomic,copy) NSString*namePY;
@end
