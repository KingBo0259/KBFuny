//
//  KBMakeCaculateManager.m
//  KBFuny
//
//  Created by jinlb on 2017/2/24.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import "KBMakeCaculateManager.h"

@implementation KBMakeCaculateManager
{

    
}

-(instancetype)init
{

    if (self = [super init ]) {
        _maker = [KBMakeCaculate new];
    }
    return self;

}



-(NSInteger)makeCaculateContrains:(void(^)(KBMakeCaculate * caculateMaker))maker{
    maker(_maker);
    return _maker.reuslt;
}
@end
