//
//  Person.h
//  KBFuny
//
//  Created by jinlb on 15/5/16.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol Person <NSObject>
@property(assign,nonatomic)int age;
@property(copy,nonatomic) NSString *name;
@end
