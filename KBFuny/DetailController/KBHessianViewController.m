//
//  KBHessianViewController.m
//  KBFuny
//
//  Created by jinlb on 15/5/16.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import "KBHessianViewController.h"


#import <HealthKit/HealthKit.h>
#import "CWHessianConnection.h"
#import "CWHessianArchiver.h"
#import "CWValueObject.h"


#import "Service.h"
#import "Person.h"

#import "UnionpayOrderTransDTO.h"
#import "UnionpayRechargeDTO.h"
#import "UnionpayService.h"

#import "paymentService.h"

#import "activityService.h"

@interface KBHessianViewController ()

@end

@implementation KBHessianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click:(UIButton*)sender {
//    NSURL* url=[NSURL URLWithString:@"http:/someserver.org/hessianservice"];
//    CWDistantHessianObject<Service> *person=[CWHessianConnection proxyWithURL:url protocol: @protocol(Service)];
//    id<Service> service=(id<Service>)[CWHessianConnection proxyWithURL:url protocol: @protocol(Service)];
//    id<Person> person=(id<Person>)[ CWValueObject valueObjectWithProtocol:@protocol(Person)];
//    [person setAge:12];
    
    if (sender.tag==1) {
    NSURL* url=[NSURL URLWithString:@"http:/192.168.99.74:8080/trade/unionpayService"];
    id<UnionpayService> service=(id<UnionpayService>)[CWHessianConnection proxyWithURL:url protocol: @protocol(UnionpayService)];
    //客户端与服务器端的方法关联.可以用不一样的方法名.通过 CWHessianArchiver 映射,就可以解决找不到方法
    [CWHessianArchiver setMethodName:@"recharge" forSelector:@selector(recharge:)];
    
    //User 与服务器端的com.listentek.signIn.server.model.User进行关联映射,否则找不到实体类.带上包名.
    [CWHessianArchiver setClassName:@"com.kuaihuoyun.biz.trade.unionpay.dto.UnionpayRechargeDTO"forProtocol:@protocol(UnionpayRechargeDTO)];

     //
    [CWHessianUnarchiver setProtocol:@protocol(UnionpayOrderTransDTO) forClassName:@"com.kuaihuoyun.biz.trade.freight.dto.UnionpayOrderTransDTO"];
        
        
    id<UnionpayRechargeDTO> rechargeDTO=(id<UnionpayRechargeDTO>)[CWValueObject valueObjectWithProtocol:@protocol(UnionpayRechargeDTO)];
    [rechargeDTO setAmt:@(100.12)];
    [rechargeDTO setTitle:@"iosTest"];
    [rechargeDTO setUserId:@"551ca0e3e4b078caaf2cdd75"];
   id<UnionpayOrderTransDTO> result= [service recharge:rechargeDTO];
        
        
    NSLog(@"%@",result.fundId);
    }else if (sender.tag==2)
    {
//        NSURL* url=[NSURL URLWithString:@"http:/192.168.4.30:8080/trade/paymentService"];
        NSURL* url=[NSURL URLWithString:@"http:/192.168.6.144:8080/trade/paymentService"];

        id<paymentService> service=(id<paymentService>)[CWHessianConnection proxyWithURL:url protocol: @protocol(paymentService)];
        //客户端与服务器端的方法关联.可以用不一样的方法名.通过 CWHessianArchiver 映射,就可以解决找不到方法
        [CWHessianArchiver setMethodName:@"alipayRecharge" forSelector:@selector(alipayRecharge:)];
        
        //AlipayRechargeDTO 与服务器端的com.kuaihuoyun.pay.dto.UnionpayRechargeDTO进行关联映射,否则找不到实体类.带上包名.
        [CWHessianArchiver setClassName:@"com.kuaihuoyun.pay.dto.AlipayRechargeDTO"forProtocol:@protocol(AlipayRechargeDTO)];
        
        
        //出参 映射
        [CWHessianUnarchiver setProtocol:@protocol(AlipayRechargeResultDTO) forClassName:@"com.kuaihuoyun.pay.dto.AlipayRechargeResultDTO"];
        id<AlipayRechargeDTO> request=(id<AlipayRechargeDTO>)[CWValueObject valueObjectWithProtocol:@protocol(AlipayRechargeDTO)];
        [request setAmount:@(100)];
        [request setOrderNo:@""];
        [request setUserId:@"123"];
        id<AlipayRechargeResultDTO> result=( id<AlipayRechargeResultDTO>)[service alipayRecharge:request];
        NSLog(@"%@",result.fundId);
        
    }else if (sender.tag==3){
    
        NSURL* url=[NSURL URLWithString:@"http:/192.168.6.144:9901/trade/activityService"];
        id<activityService> service=(id<activityService>)[CWHessianConnection proxyWithURL:url protocol: @protocol(activityService)];
        //客户端与服务器端的方法关联.可以用不一样的方法名.通过 CWHessianArchiver 映射,就可以解决找不到方法
        
        //出参 映射
        [CWHessianUnarchiver setProtocol:@protocol(RechargeActivityDTO) forClassName:@"com.kuaihuoyun.pay.dto.RechargeActivityDTO"];
        [CWHessianUnarchiver setProtocol:@protocol(RechargeDTO) forClassName:@"com.kuaihuoyun.pay.dto.RechargeDTO"];

        
        id<RechargeActivityDTO> result=( id<RechargeActivityDTO>)[service getRechargeActivity];
        NSLog(@"%@",result);
    
        for (id temp in result.rechargeList) {
            id<RechargeDTO> recharge=(id<RechargeDTO>)temp;
            NSLog(@"%@,%@,%@",recharge.rechargeAmount,recharge.couponAmount,recharge.url);
        }
        
    }
    
    
    
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
