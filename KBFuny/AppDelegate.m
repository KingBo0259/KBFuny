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
    [self checkPasteBorardContext];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
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
