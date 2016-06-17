//
//  Tiger.m
//  KBFuny
//
//  Created by jinlb on 16/2/3.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "Tiger.h"

@implementation Tiger
-(NSString*)nameWith:(NSString *)firstName lastName:(NSString *)lastName{
    return [NSString stringWithFormat:@"tiger:%@%@",firstName,lastName];
}

-(NSString*)metodSwizingToLionTest{

    NSLog(@"Tiger Method swzing");

    return @"I am Tiger MehtodSwizzing";
}
@end
