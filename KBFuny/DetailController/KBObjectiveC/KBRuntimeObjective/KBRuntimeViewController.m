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
    
    
   
    
    
    UIButton *propertyBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [propertyBtn setTitle:@"获取对象属性" forState:UIControlStateNormal];
    propertyBtn.backgroundColor=[UIColor redColor];
    [propertyBtn addTarget:self action:@selector(buttonPropertyClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:propertyBtn];
  
    
    UIButton *nonSELBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [nonSELBtn setTitle:@"执行resolveInstanceMethod添加方法" forState:UIControlStateNormal];
    nonSELBtn.backgroundColor=[UIColor redColor];
    
    [nonSELBtn addTarget:self action:@selector(resolveInstanceMethod_m) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nonSELBtn];
    
    UIButton *nonSELBtn1=[UIButton buttonWithType:UIButtonTypeSystem];
    [nonSELBtn1 setTitle:@"执行forwardingTargetForSelector" forState:UIControlStateNormal];
    nonSELBtn1.backgroundColor=[UIColor redColor];
    
    [nonSELBtn1 addTarget:self action:@selector(metodSwizingToLionTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nonSELBtn1];
    
    
    UIButton *errorButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [errorButton setTitle:@"调用没有声明的方法全错过程" forState:UIControlStateNormal];
    errorButton.backgroundColor=[UIColor redColor];
    
    [errorButton addTarget:self action:@selector(soud) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:errorButton];


    
    [button01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@200);
        make.height.equalTo(@40);
        make.top.equalTo(self.view).offset(64+20);
        make.left.equalTo(self.view).offset(20);
        
        
    }];
    
    [propertyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.with.height.equalTo(button01);
        make.top.equalTo(button01.mas_bottom).offset(10);
    }];
    
    
    
    
    [nonSELBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(propertyBtn);
        make.width.equalTo(@300);
        make.top.equalTo(propertyBtn.mas_bottom).offset(10);
    }];
    
    [nonSELBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.with.height.equalTo(nonSELBtn);
        make.top.equalTo(nonSELBtn.mas_bottom).offset(10);
    }];
    
    [errorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.with.height.equalTo(nonSELBtn1);
        make.top.equalTo(nonSELBtn1.mas_bottom).offset(10);
    }];
    

    


    

}


#pragma mark - OVVRIDE

//1、在没有找到指定的IMP之后 ，会执行resolveInstanceMethod
+(BOOL)resolveInstanceMethod:(SEL)sel{

    NSLog(@"resolveInstanceMethod:%@",NSStringFromSelector(sel));
    
    //这里可以动态的添加方法
    if (sel==NSSelectorFromString(@"resolveInstanceMethod_m")) {

        //runtime动态添加方法
        class_addMethod(self, sel, (IMP)dynamicMethodIMP, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
//动态添加方法
void dynamicMethodIMP(id self,SEL _cmd){
    NSLog(@"doSomething SEL");
}

//2、resolveInstanceMethod 还没有找到之后会执行forwardingTargetForSelector . 这样就不会报错
-(id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"forwardingTargetForSelector:%@",NSStringFromSelector(aSelector));

    if (aSelector==NSSelectorFromString(@"metodSwizingToLionTest")) {
        Class class=NSClassFromString(@"Tiger");
        id obj=[class new];
        return obj;//将方法转接到  Tiger 对象里面 ---->牛B
    }
    return nil;
}

//3、若forwardingTargetForSelector 返回nil 或则self 则执行 methodSignatureForSelector
-(NSMethodSignature*)methodSignatureForSelector:(SEL)aSelector{

    NSLog(@"methodSignatureForSelector:%@",NSStringFromSelector(aSelector));
    /*
     * 1、这里可以获取任意类型的method
     * 这里是测试对象 将其转到Lion  中过的 soud 方法中
     */
    Method method = class_getInstanceMethod(NSClassFromString(@"Lion"), NSSelectorFromString(@"soud"));

    struct objc_method_description *md=method_getDescription(method);
    NSMethodSignature  *methodSignature = [NSMethodSignature signatureWithObjCTypes:(*md).types];
   
    // 若返回有效的 NSMethodSignature会执行 forwardInvovation，否则 不会执行到 forwardInvocation
    return methodSignature;

}

//4、若methodSignatureForSelector 返回有效的NSMethodSignature  则执行 forwardInvocation  (最终若这没有执行则 最终会抛出异常)
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    
//    //创建一个函数签名，这个签名可以是任意的,但需要注意，签名函数的参数数量要和调用的一致。
//    NSMethodSignature * sig  = [NSNumber instanceMethodSignatureForSelector:@selector(init)];

    NSString* selectorName = NSStringFromSelector([anInvocation selector]);
    Class class=NSClassFromString(@"Lion");
    id obj= [class new];
    //设置target
    [anInvocation setTarget:obj];
    //设置selecteor
    [anInvocation setSelector:NSSelectorFromString(selectorName)];
    //消息调用
    [anInvocation invoke];
    
    
    
}

#pragma mark - EVENT
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
