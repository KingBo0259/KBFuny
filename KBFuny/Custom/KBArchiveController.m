//
//  KBArchiveController.m
//  KBFuny
//
//  Created by jinlb on 15/5/22.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import "KBArchiveController.h"
#import "KCUserLoginResponse.h"

#define kUserKey @"UserKey"


@implementation KBArchiveController

- (IBAction)mySwitch:(UISwitch *)sender {
    NSLog(@"select:%hhd",sender.on);
    
}


- (IBAction)archiveClick:(id)sender {
    
  KCUserLoginResponse *user=  [KCUserLoginResponse shareInstance];
    user.userId=@"1365660293";
    user.data=[KCUserLoginDataResponse alloc];
    user.data.money=@"123";
    user.data.secretKey=@"secretkey";
    
    user.data.address=[KCAddressResponse new];
    user.data.address.address=@"adderss";
    user.data.address.name=@"name";
    user.data.address.location=[KCLocationResponse new];
    user.data.address.location.lat=12.001;
    user.data.address.location.lng=13.09;
    
    
    NSMutableData *data=[[NSMutableData alloc]init];
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    
    
    [archiver encodeObject:user forKey:kUserKey];
    [archiver finishEncoding];

    self.data=data;
    NSLog(@"%@",data);
    
    NSString *archivePath=[self savePath] ;
    NSString *fileName=[archivePath stringByAppendingPathComponent:@"test"];
    
    //写入文件
    [data writeToFile:fileName atomically:YES];
//  [data writeToFile:self.archivingFilePath atomically:YES];
}

- (IBAction)unArchiveClick:(id)sender {
//    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:self.archivingFilePath];
    NSString *archivePath=[self savePath] ;
    NSString *fileName=[archivePath stringByAppendingPathComponent:@"test"];
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:fileName];
    NSKeyedUnarchiver *unarchiver=[[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    KCUserLoginResponse  *user=  [unarchiver decodeObjectForKey:kUserKey];
    [unarchiver finishDecoding];
    NSLog(@"%@",user.userId);
}


-(NSString*)savePath{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
@end
