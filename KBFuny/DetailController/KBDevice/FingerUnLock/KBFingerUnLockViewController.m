//
//  KBFingerUnLockViewController.m
//  KBFuny
//
//  Created by jinlb on 16/9/6.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBFingerUnLockViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation KBFingerUnLockViewController

-(void)viewDidLoad{

    [super viewDidLoad];
    
    [self initUI];
}


-(void)initUI{

    self.title=@"指纹识别";
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    UILabel *lable=[UILabel new];
    lable.text=@"请按home键指纹解锁";
    lable.textAlignment=NSTextAlignmentCenter;

    [self.view addSubview:lable];
    
    [lable makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        
    }];
    
    
    //创建LAContext
    LAContext *context = [LAContext new];
    
    //这个属性是设置指纹输入失败之后的弹出框的选项
    context.localizedFallbackTitle = @"没有忘记密码";
    
    
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        NSLog(@"支持指纹识别");
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请按home键指纹解锁" reply:^(BOOL success, NSError * _Nullable error) {
            

            if (success) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    NSLog(@"验证成功 刷新主界面");
                    lable.text=@"验证成功 刷新主界面";
                }];
            }else{
                NSLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"系统取消授权，如其他APP切入");
                        lable.text=@"系统取消授权，如其他APP切入";

                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        NSLog(@"用户取消验证Touch ID");
                        lable.text=@"用户取消验证Touch ID";

                        break;
                    }
                    case LAErrorAuthenticationFailed:
                    {
                        NSLog(@"授权失败");
                        lable.text=@"授权失败";

                        break;
                    }
                    case LAErrorPasscodeNotSet:
                    {
                        NSLog(@"系统未设置密码");
                        lable.text=@"系统未设置密码";

                        break;
                    }
                    case LAErrorTouchIDNotAvailable:
                    {
                        NSLog(@"设备Touch ID不可用，例如未打开");
                        lable.text=@"设备Touch ID不可用，例如未打开";

                        break;
                    }
                    case LAErrorTouchIDNotEnrolled:
                    {
                        NSLog(@"设备Touch ID不可用，用户未录入");
                        lable.text=@"设备Touch ID不可用，用户未录入";

                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"用户选择输入密码，切换主线程处理");
                            lable.text=@"用户选择输入密码，切换主线程处理";

                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"其他情况，切换主线程处理");
                            lable.text=@"其他情况，切换主线程处理";

                        }];
                        break;
                    }
                }
            }
        }];
    }else{
        NSLog(@"不支持指纹识别");
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                lable.text=@"TouchID is not enrolled";

                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                lable.text=@"A passcode has not been set";

                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                lable.text=@"TouchID not available";

                break;
            }
        }
        
        NSLog(@"%@",error.localizedDescription);
    }
    
}

@end
