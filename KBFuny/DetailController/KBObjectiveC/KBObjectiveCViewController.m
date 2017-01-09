//
//  KBObjectiveCViewController.m
//  KBFuny
//
//  Created by jinlb on 16/2/3.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBObjectiveCViewController.h"
#import "Tiger.h"
#import "Lion.h"
#import <objc/runtime.h>
#import "Masonry.h"
#import "UIButton_KB.h"
#import "UIButton+KB.h"

//全局变量，constString1地址不能修改，constString1值能修改
const NSString *constString1 = @"I am a const NSString * string";
//意义同上，无区别
NSString const *constString2 = @"I am a NSString const * string";
// stringConst 地址能修改，stringConst值不能修改
NSString * const stringConst = @"I am a NSString * const string";




@interface KBObjectiveCViewController (){

    Tiger *_tiger;

    __weak UILabel *kvoLabel;
}

@end

@implementation KBObjectiveCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self UIInit];
    
}

-(void)UIInit{
    
    constString1=stringConst;
    NSLog(@"%@;%p,%p",constString1,constString1,stringConst);
    
   
    
    
    self.title=@"Objective-C 特性";
    self.view.backgroundColor=[UIColor whiteColor];
    CGFloat left=10,top=80,width=200,height=30;

    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"obj_msgSend" forState:UIControlStateNormal];
    button.frame=CGRectMake(left, top,width, height);
    button.backgroundColor=[UIColor redColor];
    [button addTarget:self action:@selector(buttonClick:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    top=button.frame.origin.y+height+10;
    button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"method_swizzing" forState:UIControlStateNormal];
    button.frame=CGRectMake(left, top,width, height);
    button.backgroundColor=[UIColor redColor];
    [button addTarget:self action:@selector(methodSwizzing:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    top=button.frame.origin.y+height+10;
    button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"KVO" forState:UIControlStateNormal];
    button.frame=CGRectMake(left, top,width, height);
    button.backgroundColor=[UIColor redColor];
    [button addTarget:self action:@selector(KVOClick:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(2*left+width, top, width, height)];
    label.text=@"我是测试 你干什么";
    label.textColor=[UIColor redColor];
    kvoLabel=label;
    [self.view addSubview:label];
    _tiger=[Tiger new];
    
    [_tiger addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    
    
    UIButton *runtimeBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [runtimeBtn setTitle:@"RuntimeButton" forState:UIControlStateNormal];
    runtimeBtn.backgroundColor=[UIColor redColor];
    [runtimeBtn addTarget:self action:@selector(pushToRuntimeController:) forControlEvents:UIControlEventTouchUpInside];
    [runtimeBtn setMyTag:@"我是自定义Tag"];
    [self.view addSubview:runtimeBtn];
    
    [runtimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(button.mas_bottom).offset(10);
        make.left.right.with.height.equalTo(button);
    }];
    
    
    UIButton *cryption=[UIButton buttonWithType:UIButtonTypeSystem];
    [cryption addTarget:self action:@selector(encryptionClick:) forControlEvents:UIControlEventTouchUpInside];
    [cryption setTitle:@"加密/解密" forState:UIControlStateNormal];
    cryption.backgroundColor=[UIColor redColor];
    [self.view addSubview:cryption];
    
    [cryption makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(runtimeBtn.mas_bottom).offset(10);
        make.left.right.with.height.equalTo(runtimeBtn);
        
    }];

    
    
}

-(void)encryptionClick:(id)sender{

    Class class=NSClassFromString(@"KBEncryptionViewController");
 
    id obj=[class new];
    
    [self.navigationController pushViewController:obj
                                         animated:YES];

    
}

-(void)dealloc{
    //这里必须解除  观察者模式
    [_tiger removeObserver:self forKeyPath:@"name"];
}

//KVO test
-(void)KVOClick:(id)sender{

    _tiger.name=@"Kingbo";
    for (int i=0; i<=100000; ++i) {
        @autoreleasepool {
            [self logTestValue:i];
            
        }
    }
    sleep(1);
    
}

-(void)logTestValue:(int)index{
    NSLog(@"%i",index);
}


-(void)pushToRuntimeController:(UIButton*)sender{
    Class class=NSClassFromString(@"KBRuntimeViewController");
    id obj=[class new];
    [self.navigationController pushViewController:obj animated:YES];
}

///发消息
-(void)buttonClick:(UIButton*)sender{

//    Animal *animal=[Tiger new];
//    //消息发送
//    id returnValue=objc_msgSend(animal,NSSelectorFromString(@"nameWith:lastName:"),@"jin",@"lingbo");
//    
//    NSLog(@"%@",returnValue);
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"objc_msgSend" message:returnValue delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
    
}

//开始 method swizzing 交互
-(void)methodSwizzing:(id)sender{

    //（同一个类中方法调用）开始获取方法
    Method originMethod=class_getInstanceMethod([Lion class], @selector(legs));
    Method swappeMehtod=class_getInstanceMethod([Lion class], @selector(soud));
    
    //开始交换
    method_exchangeImplementations(originMethod, swappeMehtod);
    

    //测试
    Lion *lion=[Lion new];

    NSLog(@"test legs");
    [lion legs];//实际上会调用 Lion=====> soud 里面的东西
    
    
    NSLog(@"test soud");
    [lion soud];//实际上会调用 Lion======> legs  方法

    //测试不同类之间交换
    //（同一个类中方法调用）开始获取方法
     originMethod=class_getInstanceMethod([Lion class], @selector(legs));
     swappeMehtod=class_getInstanceMethod([Tiger class], @selector(metodSwizingToLionTest));
    
    //开始交换
    method_exchangeImplementations(originMethod, swappeMehtod);

    
    NSLog(@"tiger test legs");
    [lion legs];//实际上会调用 Tiger=====> metodSwizingToLionTest 里面的东西
    

    
}

#pragma mark - KVO ober

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context

{

    
    if ([keyPath isEqualToString:@"name"]) {
        NSLog(@"%@",[change objectForKey:@"old"]);
        kvoLabel.text=[change objectForKey:@"new"];
    }

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
