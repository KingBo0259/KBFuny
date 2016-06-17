//
//  KCAddressResponse.h
//  kuaidihuoyun
//
//  Created by jinlb on 14/12/11.
//  Copyright (c) 2014年 banyanan. All rights reserved.
//

#import "KCAddressResponse.h"
#import <Foundation/Foundation.h>


@interface KCLocationResponse : NSObject<NSCoding>
@property (nonatomic,assign)double lng;
@property (nonatomic,assign)double lat;
@end


@interface KCAddressResponse : NSObject<NSCoding>
@property (nonatomic,assign)NSInteger address_id;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,strong)KCLocationResponse *location;
@end
