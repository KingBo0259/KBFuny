//
//  KCAddressResponse.m
//  kuaidihuoyun
//
//  Created by jinlb on 14/12/11.
//  Copyright (c) 2014年 banyanan. All rights reserved.
//

#import "KCAddressResponse.h"

#define kLngKey  @"LngKey"
#define kLatKey  @"LatKey"

@implementation KCLocationResponse

-(id)initWithCoder:(NSCoder *)aDecoder{

    self=[super init];
    
    if (self) {
        self.lng=[aDecoder decodeDoubleForKey:kLngKey];
        self.lat=[aDecoder decodeDoubleForKey:kLatKey];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeDouble:_lat forKey:kLatKey];
    [aCoder encodeDouble:_lng forKey:kLngKey];
}
@end

#define kAddressIdKey @"AddressIdKey"
#define kAddressKey   @"AddressKey"
#define kNameKey      @"NameKey"
#define kLocationKey  @"LocationKey"

@implementation KCAddressResponse

-(id)initWithCoder:(NSCoder *)aDecoder{

    self=[super init];
    if (self) {
        self.address_id=[aDecoder decodeIntegerForKey:kAddressIdKey];
        self.address=[aDecoder decodeObjectForKey:kAddressKey];
        self.name=[aDecoder decodeObjectForKey:kNameKey];
        self.location=[aDecoder decodeObjectOfClass:[KCLocationResponse class] forKey:kLocationKey];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{

    [aCoder encodeInteger:_address_id forKey:kAddressIdKey];
    [aCoder encodeObject:_address forKey:kAddressKey];
    [aCoder encodeObject:_name forKey:kNameKey];
    [aCoder encodeObject:_location forKey:kLocationKey];
    
}
@end
