//
//  NSString+Encryption.h
//  KBFuny
//
//  Created by jinlb on 2017/1/9.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encryption)
-(NSString*)AES128EncryptWithKey:(NSString*)key andIV:(NSString*)iv;
-(NSString*)AES128DecryptWithKey:(NSString*)key andIV:(NSString*)iv;

-(NSString*)encryptionWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;
-(NSString*)decryptionWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;

@end
