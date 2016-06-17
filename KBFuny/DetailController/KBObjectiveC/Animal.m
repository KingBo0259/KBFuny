//
//  Animal.m
//  KBFuny
//
//  Created by jinlb on 16/2/3.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "Animal.h"

@implementation Animal

-(NSString*)nameWith:(NSString *)firstName lastName:(NSString *)lastName{
    return [NSString stringWithFormat:@"Animal:%@%@",firstName,lastName];
}

+(BOOL)resolveInstanceMethod:(SEL)sel{

    NSLog(@"");
    return YES;
}
@end
