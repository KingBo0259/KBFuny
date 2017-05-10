//
//  KBWeexShowcaseViewController.m
//  KBFuny
//
//  Created by jinlb on 2017/5/3.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import "KBWeexShowcaseViewController.h"
#import <WeexSDK/WeexSDK.h>

@interface KBWeexShowcaseViewController ()
@property (nonatomic, strong) WXSDKInstance *weexSDK;

@end

@implementation KBWeexShowcaseViewController



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_weexSDK destroyInstance];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.weexSDK.viewController = self;
    self.weexSDK.frame = self.view.frame;
    
    [self.weexSDK renderWithURL:self.weexUri];
    
    __weak typeof(self) weakSelf = self;
    self.weexSDK.onCreate = ^(UIView *view) {
        [weakSelf.view addSubview:view];
    };
    
    self.weexSDK.renderFinish = ^(UIView *view) {
        view.backgroundColor = [UIColor yellowColor];
        NSLog(@"view:%@",view);
    };
    
    self.weexSDK.onFailed = ^(NSError *error) {
        NSLog(@"weexSDK onFailed : %@\n", error);
    };
    
    [self initRightItem];
}

-(void)initRightItem {

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    self.navigationItem.rightBarButtonItem = item;
}
-(void)refresh {
    [self.weexSDK reload:YES];
}

- (WXSDKInstance *)weexSDK {
    if (!_weexSDK) {
        _weexSDK = [WXSDKInstance new];
    }
    return _weexSDK;
}

@end
