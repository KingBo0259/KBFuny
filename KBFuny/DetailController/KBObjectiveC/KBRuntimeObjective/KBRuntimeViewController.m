//
//  KBRuntimeViewController.m
//  KBFuny
//
//  Created by jinlb on 16/4/15.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBRuntimeViewController.h"
#import "Masonry.h"

#import "Tiger.h"
#import <objc/runtime.h>

@interface KBRuntimeViewController ()

@end

@implementation KBRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor=[UIColor whiteColor];
    
    self.title=@"Runtime";

    [self UIInit];
}


-(void)UIInit{

    UIButton *button01=[UIButton buttonWithType:UIButtonTypeSystem];
    [button01 setTitle:@"获取成员变量 " forState:UIControlStateNormal];
    button01.backgroundColor=[UIColor redColor];
    
    [button01 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button01];
    
    
    [button01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@200);
        make.height.equalTo(@40);
        make.top.equalTo(self.view).offset(64+20);
        make.left.equalTo(self.view).offset(20);

        
    }];
    
    
    UIButton *propertyBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [propertyBtn setTitle:@"获取对象属性" forState:UIControlStateNormal];
    propertyBtn.backgroundColor=[UIColor redColor];
    [propertyBtn addTarget:self action:@selector(buttonPropertyClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:propertyBtn];
    
    [propertyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.with.height.equalTo(button01);
        make.top.equalTo(button01.mas_bottom).offset(10);
    }];
}


//
-(void)buttonPropertyClick:(id)sender{

    Tiger  *tiger=[Tiger new];
    
    tiger.name=@"test Tiger";
    Class class=[tiger class];
    
    while (class !=[NSObject class]) {
        
        unsigned int propertyCounts=0;
       objc_property_t *propertys= class_copyPropertyList(class, &propertyCounts);
        
        
        for (const objc_property_t *p=propertys; p<propertys+propertyCounts; p++) {
            
            objc_property_t const varp=*p;
            
        
            NSString*propertyName= [NSString stringWithUTF8String:  property_getName(varp)];
            const char *type=property_getAttributes(varp);
            NSString *typeName=[NSString stringWithUTF8String:type];
            
            NSLog(@"PropertyName=%@,PropertyType=%@",propertyName,typeName);
        }
        
        
        class=class_getSuperclass(class);
    }
}


//遍历对象成员变量
-(void)buttonClick:(id)sender{

    

    Class class=NSClassFromString(@"Tiger");
    
    
    while (class!=[NSObject class]) {
    unsigned int numberofIvars=0;
    
     Ivar *ivars=class_copyIvarList(class, &numberofIvars);
        for (const Ivar *p=ivars; p<ivars+numberofIvars; p++) {//采用指针+1 来获取下一个变了
        
            Ivar const ivar=*p;//取得这个变量
            const char *type=ivar_getTypeEncoding(ivar);//取得这个变量的类型
            NSString*key=[NSString stringWithUTF8String:ivar_getName(ivar)];
            NSLog(@"++Name=\"%@\"  Type=\"%@\"",key,[NSString stringWithUTF8String:type]);
        }
        //获取父类
        class = class_getSuperclass(class);

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
