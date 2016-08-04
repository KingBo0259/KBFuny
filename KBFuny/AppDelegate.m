//
//  AppDelegate.m
//  KBFuny
//
//  Created by jinlb on 15/2/27.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window makeKeyAndVisible];
    
    
//    UIImageView *splashView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0
//                                                                          ,[UIScreen mainScreen].bounds.size.width
//                                                                          ,[UIScreen mainScreen].bounds.size.height)];
//    splashView.image=[UIImage imageNamed:@"Default"];
//    [self.window addSubview:splashView];
//    [self.window bringSubviewToFront:splashView];
//    //设置动画效果
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:3.0];
//    [UIView setAnimationDelegate:self];
//    splashView.alpha=0.0;
//    splashView.frame=CGRectMake(-60, -90, 440, 700);
//    [UIView commitAnimations];
//
    
    NSLog(@"didFinishLaunchingWithOptions：%@",launchOptions);

    NSLog(@"newBranch01");
    NSLog(@"newBranch02");
    
//    [UIView animateWithDuration:3.0
//                        animations:^{
//                            splashView.alpha=0.0;
//                            splashView.transform=CGAffineTransformMakeScale(1.4, 1.4);
//                        }];
//    sleep(5);
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


/*
 对比 applicationWillEnterForeground
 和 applicationDidBecomeActive
 这两个方法，前者是指 App从后台进入前台，后者是指 App处于活跃状态，所以前者相对于后者，缺少的部分是，当 App 刚刚启动，而不是从后台取出的时候，它无法识别剪贴板。
 */
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
    [self checkPasteBorardContext];

}

//当一个应用程序被其他程序打开的时候会调用这个方法，在该方法中可以实现两个应用程序间的数据局传递

-(BOOL)application:(UIApplication*)application openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation{

    NSString *urlString=url.absoluteString;
  NSArray *urlArray=  [urlString componentsSeparatedByString:@"="];
    NSString *sourcApplicationURL=urlArray[1];
    NSLog(@"%@",url.absoluteString);
    

    
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"来自KBSwiftFuny" message:@"是否返回应用?" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        NSURL *url=[[NSURL alloc]initWithString:[sourcApplicationURL stringByAppendingString:@":"]];
        [[UIApplication  sharedApplication] openURL:url];
    }];
    
    [alertController addAction:okAction];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];

    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//淘宝复制分享 打开内容
-(void)checkPasteBorardContext{

    //剪切板内容
    NSString* paste=  [UIPasteboard generalPasteboard].string;
    if (!paste|| [paste isEqualToString:@"我是开发自定义的"]) {
        return;
    }
    [UIPasteboard generalPasteboard].string=@"我是开发自定义的";//清空
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"要打开剪贴板中的链接" message:paste preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action=[UIAlertAction  actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"哈哈 你真打开了啊，笨"
                                                         message:paste
                                                        delegate:nil
                                               cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
            [alert show];

        
    }];
    [alertController addAction:action];
    [alertController addAction:okAction];


    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    
}
@end
