//
//  KBEncryptionViewController.m
//  KBFuny
//
//  Created by jinlb on 2017/1/9.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import "KBEncryptionViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSString+Encryption.h"
#import "NSData+Encryption.h"




static  const NSString * kAECKey   = @"myTest124";
static  const NSString * kIV       = @"myTestKiv";



enum  {
    NJHashTypeMD5=0,
    NJHashTypeSHA1,
    NJHashTypeSHA256
}; typedef NSUInteger NJHashType;


@interface KBEncryptionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UITextView *encryptionTextFeild;

@end

@implementation KBEncryptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor flatPinkColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClick:(UIButton *)sender {
    [self.view endEditing:YES];
    NSString *result=nil;
    if (sender.tag==1) {
        
       result= [self hashWithType:NJHashTypeMD5 andInputString:_inputTextField.text];
        
    }else if (sender.tag==2){
    
    
        result=[self hashWithType:NJHashTypeSHA1 andInputString:_inputTextField.text];
        
    }else if (sender.tag==3){
    
        result=[self hashWithType:NJHashTypeSHA256 andInputString:_inputTextField.text];
    }
    
    _encryptionTextFeild.text=result;
}




/**
 hash 加密

 @param type 加密类型
 @param inputString 输入字符
 @return 解码结果
 */
-(NSString*)hashWithType:(NJHashType)type andInputString:(NSString*)inputString{

    const char *ptr=[inputString UTF8String];
    
    NSInteger bufferSize;
    switch (type) {
        case NJHashTypeMD5:
            // 16 bytes
            bufferSize=CC_MD5_DIGEST_LENGTH;
            break;
            
            case NJHashTypeSHA1 :
            //20 bytes
            bufferSize=CC_SHA1_DIGEST_LENGTH;
            break;
            case NJHashTypeSHA256:
            //32 bytes
            bufferSize=CC_SHA256_DIGEST_LENGTH;
            break;
            
        default:
            return nil;
            break;
            
    }
    
    unsigned char buffer[bufferSize];
    
    switch (type) {
        case NJHashTypeMD5:
            CC_MD5(ptr, strlen(ptr), buffer);
            break;
        case NJHashTypeSHA1:
            CC_SHA1(ptr, strlen(ptr), buffer);
            break;
            
        case NJHashTypeSHA256:
            
            CC_SHA256(ptr, strlen(ptr), buffer);
            break;
        default:
            break;
    }
    
    
    NSMutableString *hashString=[NSMutableString stringWithCapacity:bufferSize*2];
    
    for (int i=0; i<bufferSize; ++i) {
       [hashString appendFormat:@"%02x",buffer[i] ];
    }
    
    return hashString;
}


-(IBAction)AESClick:(id)sender{
    [self.view endEditing:YES];

    NSString *body = _inputTextField.text;
    
    //1、加密   2、然后对数据进行base64， 这样就能得到可见数据；
    NSString *encryptionBody = [body AES128EncryptWithKey:kAECKey andIV:kIV];
    
    _encryptionTextFeild.text = encryptionBody?encryptionBody:@"计算错误";
    

}

- (IBAction)DeAESClick:(id)sender {
    [self.view endEditing:YES];

    NSString *body = _inputTextField.text;
    NSString *base64EncodeString = body;
    
    //1、 需要base64 解码 ==>得到原加密数据
    NSData *decodeDataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:base64EncodeString options:0];
    //2、对加密数据进行解密
    NSData *decrypData=  [decodeDataFromBase64String AES128DecryptWithKey:kAECKey iv:kIV];
    //3、NSData转 NSString
    NSString *decodedString = [[NSString alloc]
                              initWithData:decrypData encoding:NSUTF8StringEncoding];
    
    
    _encryptionTextFeild.text = decodedString?decodedString:@"计算错误";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
