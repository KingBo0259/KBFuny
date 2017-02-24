//
//  KBMakeCaculateManager.h
//  KBFuny
//
//  Created by jinlb on 2017/2/24.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBMakeCaculate.h"

@interface KBMakeCaculateManager : NSObject
@property(strong,nonatomic) KBMakeCaculate *maker;


-(NSInteger)makeCaculateContrains:(void(^)(KBMakeCaculate * caculateMaker))maker;
@end
