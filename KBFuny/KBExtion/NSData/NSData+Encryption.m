//
//  NSData+Encryption.m
//  KBFuny
//
//  Created by jinlb on 2017/1/9.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import "NSData+Encryption.h"

@implementation NSData (Encryption)

//加密
- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv
{
    return [self AES128operation:kCCEncrypt key:key iv:iv];
}

//解密
- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv
{
    return [self AES128operation:kCCDecrypt key:key iv:iv];
}

- (NSData *)AES128operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv
{
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    // IV
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [self length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    
    CCCryptorStatus cryptorStatus = CCCrypt(operation,
                                            kCCAlgorithmAES128,
                                            kCCOptionPKCS7Padding,
                                            keyPtr,
                                            kCCKeySizeAES128,
                                            ivPtr,
                                            [self bytes], [self length],
                                            buffer, bufferSize,
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess){
        NSLog(@"Success");
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }else{
        NSLog(@"Error");
    }
    
    free(buffer);
    return nil;
}

-(NSData*)encryptionWith3DESUsingKey:(NSString*)key andIV:(NSString*)iv{
    
//    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
//    
//    size_t dataMoved;
//    NSMutableData *encryptedData = [ NSMutableData dataWithLength:self.length+kCCBlockSizeAES128];
//    
//    
//    CCCryptorStatus status = CCCrypt(kCCEncrypt,
//                                     kCCAlgorithm3DES,
//                                     kCCOptionPKCS7Padding,
//                                     keyData.bytes,
//                                     keyData.length,
//                                     iv.bytes,
//                                     self.bytes,
//                                     self.length,
//                                     encryptedData.mutableBytes,
//                                     encryptedData.length,
//                                     &dataMoved
//                                     );
//    if (status == kCCSuccess) {
//        encryptedData.length = dataMoved;
//        return encryptedData;
//    }
    
    
    return nil;


    
}


+(NSData*)blockInitializationVectorOfLength:(size_t)ivLength{

    if (ivLength == 0) {
        ivLength = kCCBlockSizeAES128;
    }

    NSMutableData * iv = [NSMutableData dataWithLength:ivLength];
    int ivResult = SecRandomCopyBytes(kSecRandomDefault,
                                      ivLength,
                                      iv.mutableBytes);
    
    if (ivResult == noErr) {
        return iv;
    }
    return nil;
}

@end
