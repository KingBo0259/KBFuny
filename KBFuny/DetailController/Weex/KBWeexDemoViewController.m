//
//  KBWeexDemoViewController.m
//  KBFuny
//
//  Created by jinlb on 2017/5/3.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import "KBWeexDemoViewController.h"
#import <WeexSDK/WeexSDK.h>
#import "KBWeexShowcaseViewController.h"

@interface KBWeexDemoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *locationJsNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@end

@implementation KBWeexDemoViewController
- (void)initWeex {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [WXAppConfiguration setAppGroup:@"AliApp"];
        [WXAppConfiguration setAppName:@"WeexDemo"];
        [WXAppConfiguration setAppVersion:@"1.0.0"];
        [WXSDKEngine initSDKEnvironment];
        [WXLog setLogLevel:1<<0];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initWeex];
    self.title = @"weex demo";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showWeexClick:(id)sender {
    NSString *str = _urlTextField.text;
//    WXBaseViewController *baseWeexController = [[WXBaseViewController alloc] initWithSourceURL:[NSURL URLWithString:@"http://192.168.20.108:8081/helloWeex.js"]];
    //自定义类
    KBWeexShowcaseViewController *vc = [KBWeexShowcaseViewController new];
    vc.weexUri = [NSURL URLWithString:str];
    [self.navigationController pushViewController:vc animated:YES];
}

-(IBAction)showLocationWeexClick:(id)sender {
    //1、获取路径方式一
//    NSString *jsPath = [[NSBundle mainBundle] pathForResource:_locationJsNameTextField.text ofType:@"js"];
//    jsPath = [@"file://" stringByAppendingString:jsPath];
    //2、获取路径方式二
    NSString *filePath = _locationJsNameTextField.text;
    NSString *path=[NSString stringWithFormat:@"file://%@/%@.js",[NSBundle mainBundle].bundlePath,filePath];
    NSLog(@"-----path:%@",path);
    NSURL * jsUrl=[NSURL URLWithString:path];
    KBWeexShowcaseViewController *vc = [KBWeexShowcaseViewController new];
    vc.weexUri = jsUrl;
    [self.navigationController pushViewController:vc animated:YES];

}


@end
