//
//  Service.h
//  KBFuny
//
//  Created by jinlb on 15/5/16.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@protocol Service <NSObject>
-(int)getPersonCount;
-(id<Person>)getPerson:(int)index;
@end
