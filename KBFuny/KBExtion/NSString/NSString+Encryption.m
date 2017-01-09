//
//  NSString+Encryption.m
//  KBFuny
//
//  Created by jinlb on 2017/1/9.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import "NSString+Encryption.h"
#import "NSData+Encryption.h"

@implementation NSString (Encryption)
-(NSString*)AES128EncryptWithKey:(NSString*)key andIV:(NSString*)iv{

    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] AES128EncryptWithKey:key
                                                iv:iv];

    NSString * encryptedString = [encrypted base64EncodedStringWithOptions:0];
    
    //base64 变成明文
//    NSString *  encryptedString = [[NSString alloc]initWithData:encrypted encoding:NSASCIIStringEncoding];
    return encryptedString;
}

-(NSString*)AES128DecryptWithKey:(NSString*)key andIV:(NSString*)iv{

    
    NSData *decrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] AES128DecryptWithKey:key
                                                                                         iv:iv];
    
//    NSString *  encryptedString = [[NSString alloc]initWithData:decrypted encoding:NSASCIIStringEncoding];

        NSString *  decryptedString = [[NSString alloc]initWithData:decrypted encoding:NSUTF8StringEncoding];

    return decryptedString;

}
@end
