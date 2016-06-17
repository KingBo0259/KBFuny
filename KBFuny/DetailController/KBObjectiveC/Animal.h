//
//  Animal.h
//  KBFuny
//
//  Created by jinlb on 16/2/3.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject

@property(nonatomic,copy)NSString*legs;
-(NSString*)nameWith:(NSString*)firstName lastName:(NSString*)lastName;
@end
