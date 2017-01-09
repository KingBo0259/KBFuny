//
//  NSData+Encryption.h
//  KBFuny
//
//  Created by jinlb on 2017/1/9.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>


@interface NSData (Encryption)
- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv;
- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv;

-(NSData*)encryptionWith3DESUsingKey:(NSString*)key andIV:(NSString*)iv;
-(NSData*)decryptionWith3DESUsingKey:(NSString*)key andIV:(NSString*)iv;


+(NSData*)blockInitializationVectorOfLength:(size_t)ivLength;
@end
