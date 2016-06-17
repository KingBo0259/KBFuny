//
//  KCTmsViewController.m
//  KBFuny
//
//  Created by jinlb on 16/4/18.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KCTmsViewController.h"
#import  "AFNetworking.h"
#import "Masonry.h"
#import "SVProgressHUD.h"
#import "KCTMSRegionService.h"
#import "KCCityListResponse.h"
#import "KCTMSRpcResponse.h"
#import "KCTmsTestDetailViewController.h"
#import "KCTMSUnarchive.h"
#import "KCTMSArchive.h"

const CGFloat ButtonWidth=200.0f;
const CGFloat ButtonHeight=44.0f;
@interface KCTmsViewController (){


    __weak UITextField *_cityTextField;
}

@property (strong,nonatomic)NSArray<NSObject *> *objArry;
@end

@implementation KCTmsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initResponseMap];
    [self initRequestMap];
    [self UIinit];
}


-(void)UIinit{

    self.view.backgroundColor=[UIColor whiteColor];
    
    self.title=@"TMS 协议测试";
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"AFNetWork TmsURL" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ButtonWidth));
        make.height.equalTo(@(ButtonHeight));
        make.top.equalTo(self.view).offset(84);
        make.left.equalTo(@20);
    }];
    
    
    UIButton *iosButtonNetWork=[UIButton buttonWithType:UIButtonTypeSystem];
    [iosButtonNetWork setTitle:@"自带请求 TmsURL" forState:UIControlStateNormal];

    [iosButtonNetWork setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [iosButtonNetWork addTarget:self action:@selector(iosButtonNetWork:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:iosButtonNetWork];
    
    [iosButtonNetWork mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.height.equalTo(button);
        
        make.top.equalTo(button.mas_bottom).offset(10);
    }];
    
    
    
    
    UIButton *serviceButtonNetWork=[UIButton buttonWithType:UIButtonTypeSystem];
    [serviceButtonNetWork setTitle:@"获取城市列表" forState:UIControlStateNormal];
    
    [serviceButtonNetWork setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [serviceButtonNetWork addTarget:self action:@selector(serviceClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:serviceButtonNetWork];
    
    [serviceButtonNetWork mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.height.equalTo(iosButtonNetWork);
        
        make.top.equalTo(iosButtonNetWork.mas_bottom).offset(10);
    }];

    
    
    UIButton *  cityButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [cityButton setTitle:@"获取单个城市信息" forState:UIControlStateNormal];
    
    [cityButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cityButton addTarget:self action:@selector(singleCityButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cityButton];
    
    [cityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.height.equalTo(serviceButtonNetWork);
        
        make.top.equalTo(serviceButtonNetWork.mas_bottom).offset(10);
    }];
    
    
    UITextField *cityField=[[UITextField alloc]init];
    cityField.backgroundColor=[UIColor whiteColor];
    cityField.borderStyle=UITextBorderStyleRoundedRect;
    cityField.textColor=[UIColor blackColor];
    _cityTextField=cityField;
    [self.view addSubview:cityField];
    
    [cityField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(cityButton.mas_centerY);
        make.width.equalTo(@100);
        make.left.equalTo(cityButton.mas_right);
    }];
    
    
    UIButton *  mulitButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [mulitButton setTitle:@"多个请求城市信息" forState:UIControlStateNormal];
    
    [mulitButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [mulitButton addTarget:self action:@selector(mulitButtonClikc:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:mulitButton];
    
    [mulitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.height.equalTo(cityButton);
        make.top.equalTo(cityButton.mas_bottom).offset(10);
    }];
    

}
#pragma mark -  TMSMap

-(void)initResponseMap{

    [KCTMSUnarchive setResposneString:@"KCCityListResponse" forTmsKey:@"TMSRegionAPI.getProvinces"];
    [KCTMSUnarchive setResposneString:@"KCCityResponse" forTmsKey:@"TMSRegionAPI.getProvince"];


}

-(void)initRequestMap{
    [KCTMSArchive setTmsKey:@"TMSRegionAPI.getProvince" forRequstString:@"KCTMSCityRequest"];
}

#pragma mark - Event
-(void)mulitButtonClikc:(id)sender{

    [_cityTextField resignFirstResponder];
    
    KCTMSRegionService *service=[KCTMSRegionService new];
    
    __weak typeof(self) __weakself=self;
    
    [service mulitRquestTestWithCityId:_cityTextField.text success:^(KCTMSRpcResponse *responseObject) {
        
        [__weakself pushToDetailWithData:[responseObject.body description] title:@"TMS多个参数请求"];
        
        
    } error:^(NSError *error) {
        [__weakself pushToDetailWithData:error.description title:@"TMS一个参数请求"];
        
        
    }];
    
}


-(void)singleCityButtonClick:(id)sender{
    
    [_cityTextField resignFirstResponder];
    
    KCTMSRegionService *service=[KCTMSRegionService new];

    __weak typeof(self) __weakself=self;
    
    
    [service getProviceWithCityId:_cityTextField.text success:^(KCTMSRpcResponse *responseObject) {
    
       [__weakself pushToDetailWithData:[responseObject.body toJSONString] title:@"TMS一个参数请求"];
       
       
    } error:^(NSError *error) {
        [__weakself pushToDetailWithData:error.description title:@"TMS一个参数请求"];

        
    }];
    

}

-(void)serviceClick:(id)sender{
    KCTMSRegionService *service=[KCTMSRegionService new];
    __weak typeof(self) __weakself=self;
    [service getProviceListWithSuccess:^(KCTMSRpcResponse *responseObject) {
        [__weakself pushToDetailWithData:[responseObject.body toJSONString] title:@"TMS无参数请求"];
    } error:^(NSError *error) {
        
        
    } ];
    
}


-(void)iosButtonNetWork:(id)sender{

    // 1.设置请求路径
    NSURL *URL=[NSURL URLWithString:@"http://192.168.6.81:8080/odin/servlet/gate"];//不需要传递参数
    
    //    2.创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    
    //设置请求体
    NSString *param=@"TMSRegionAPI.getProvinces={}";
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    //    3.发送请求
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];//同步发送request，成功后会得到服务器返回的数据

    
    NSString *str=  [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",str);
    
    [self pushToDetailWithData:str title:@"iOS 自带请求"];

    

}



-(void)buttonClick:(id)sender{

    
    
    NSString *str=[NSString stringWithFormat:@"http://192.168.6.81:8080/odin/servlet/gate"];
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    //设置请求体
    NSString *param=@"TMSRegionAPI.getProvinces={}";
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];

//    //方法一
//   AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//   AFHTTPRequestOperation*requstOperation= [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSString *html = operation.responseString;
//       
//       
//       //转为NSDiction
//        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
//       
//       NSString *cityList= [dict objectForKey:@"TMSRegionAPI.getProvinces"];
//       NSError *error;
//       
//       Class class=NSClassFromString(@"KCCityListResponse");
//        id cityListResponse=[[class alloc] initWithString:cityList error:&error];
//       
//       
//       
//      NSString*encodeStr= [cityListResponse toJSONString];
//       NSLog(@"%@",encodeStr);
//
//       [self pushToDetailWithData:encodeStr title:@"AFNetworing 请求"];
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"发生错误！%@",error);
//
//        
//    }];
//    [requstOperation start];
    
  //方法二
//    //把拼接后的字符串转换为data，设置请求体
//    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *html = operation.responseString;
//        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
//        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
//        NSLog(@"获取到的数据为：%@",dict);
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"发生错误！%@",error);
//    }];
//    
//    NSOperationQueue *queue = [NSOperationQueue  mainQueue];
//    [queue addOperation:operation];
    
  

}


-(void)pushToDetailWithData:(NSString*)data title:(NSString*)title{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.navigationController pushViewController: [[KCTmsTestDetailViewController alloc]initWithData:data title:title] animated:YES];

    });


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
