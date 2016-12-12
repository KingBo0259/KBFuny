//
//  KBScriptViewController.m
//  KBFuny
//
//  Created by jinlb on 2016/12/5.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBScriptViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface KBScriptViewController ()
@property(strong,nonatomic)JSContext *jsContext;
@end

@implementation KBScriptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initUI];
    [self initData];

}


-(void)initUI{

    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 80, 120, 40)];
    button.tag=1;
    [button setTitle:@"JS调用OC" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    button=[[UIButton alloc]initWithFrame:CGRectMake(0, 130, 120, 40)];
    button.tag=2;
    [button setTitle:@"OC调用JS" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];


}
-(void)initData{

    JSContext *jscontext=[JSContext new];
    
    jscontext[@"helloJs"]=^(NSString *value){
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"我是js调用" message:value preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self.navigationController presentViewController:alert animated:YES
                                              completion:nil];
        
        return @"I am  OC ";
    
    };
    

    _jsContext=jscontext;

}


-(void)buttonClick:(UIButton*)sender{
    
    if(sender.tag==1){
        //模拟执行 js 调用oc 方法--->执行helloJs 回调到block 中
   JSValue *jsvalue= [_jsContext evaluateScript:@"helloJs('这里模拟js代码执行OC')"];

    NSLog(@"%@",jsvalue);
    }else{
    
        //这里通过oc 调用js方法-----
        JSValue *jsValue=_jsContext[@"helloJs"];
        [jsValue callWithArguments:@[@"我是oc 传递参数给js"]];
        
        
        
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
