//
//  KCNetworkFrameworkDemoViewController.m
//  KBFuny
//
//  Created by jinlb on 16/3/2.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KCNetworkFrameworkDemoViewController.h"


@interface KCNetworkFrameworkDemoViewController ()

@end

@implementation KCNetworkFrameworkDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self action:@selector(demo) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(10, 64, 200, 64);;
    [button setTintColor:[UIColor redColor]];
    [button setTitle:@"信号量" forState:UIControlStateNormal];
    [self.view addSubview:button];
}


-(void)demo{
    // 设置一个异步线程组
     __block  NSString *message = @"呵呵";
        // 设置一个网络请求
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.github.com"]];
        // 创建一个信号量为0的信号(红灯)
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"第一步操作");
            message = @"网络结果";
            // 使信号的信号量+1，这里的信号量本来为0，+1信号量为1(绿灯)
            dispatch_semaphore_signal(sema);
        }];
        [task resume];
        // 以下还要进行一些其他的耗时操作
      NSString *temp = [NSString stringWithFormat:@"耗时操作继续进行---%@",message];
    NSLog(@"%@", temp);
        // 开启信号等待，设置等待时间为永久，直到信号的信号量大于等于1（绿灯）
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        temp = [NSString stringWithFormat:@"dispatch_semaphore_wait_end--%@",message];
    NSLog(@"%@", temp);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
