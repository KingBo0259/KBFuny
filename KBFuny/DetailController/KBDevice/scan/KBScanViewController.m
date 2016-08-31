//
//  KBScanViewController.m
//  KBFuny
//
//  Created by jinlb on 16/8/31.
//  Copyright © 2016年 jinlb. All rights reserved.
//

/*
 animationWithKeyPath的值：
 
 　 transform.scale = 比例轉換
 
 transform.scale.x = 闊的比例轉換
 
 transform.scale.y = 高的比例轉換
 
 transform.rotation.z = 平面圖的旋轉
 
 opacity = 透明度
 
 margin
 
 zPosition
 
 backgroundColor    背景颜色
 
 cornerRadius    圆角
 
 borderWidth
 
 bounds
 
 contents
 
 contentsRect
 
 cornerRadius
 
 frame
 
 hidden
 
 mask
 
 masksToBounds
 
 opacity
 
 position
 
 shadowColor
 
 shadowOffset
 
 shadowOpacity
 
 shadowRadius
 */

#import "KBScanViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface KBScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>//用于处理采集细腻下的代理
{

    
    AVCaptureSession *_session;//输入输出中间桥梁
    UIImageView *_scanNet;

}
@end

@implementation KBScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"扫描";
    self.view.backgroundColor=[UIColor whiteColor];
    
   
    
    [self initScanFrame];

    
    //获取摄像设备
    AVCaptureDevice *devic=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输人流
    AVCaptureInput *input=[AVCaptureDeviceInput deviceInputWithDevice:devic error:nil];
    //创建输出流
    AVCaptureMetadataOutput *output=[[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设置有效扫描区域 CGRectMake(Y/屏幕高度, X/屏幕宽度,heidth/屏幕高度,width/屏幕宽度) rect范围为0~1
//    output.rectOfInterest =CGRectMake(x, y, width, height);

    
    
    //初始化链接对象
    _session=[[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    [_session addInput:input];
    [_session addOutput:output];
    
    //设置扫码指出的编码格式（如下设置条形码和二维码兼容）
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer *layer=[AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    
    //开始补货
    [_session startRunning];
    
    
}


-(void)initScanFrame{
    
    
    UIView *scanWindow=[[UIView alloc]init];
    scanWindow.frame=CGRectMake(0, 0, 200, 200);
    scanWindow.backgroundColor=[UIColor clearColor];
    scanWindow.clipsToBounds=YES;
    scanWindow.center=self.view.center;
    [self.view addSubview:scanWindow];
    
    
    /******4个角图片设置*******/
    UIImageView *leftTop=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scan_1"]];
    [scanWindow  addSubview:leftTop];
    
    
    UIImageView *leftBottom=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scan_3"]];
    [scanWindow  addSubview:leftBottom];
    
    UIImageView *rightBottom=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scan_4"]];
    [scanWindow  addSubview:rightBottom];
    
    UIImageView *rightTop=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scan_2"]];
    [scanWindow  addSubview:rightTop];
    
    /*********扫描横幅***********/
    UIImageView *scanNet=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scan_net"]];
    scanNet.frame=CGRectMake(0, -200, 200, 200);
    _scanNet=scanNet;
    [scanWindow  addSubview:scanNet];
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.repeatCount=INFINITY;//无线循环
    CAMediaTimingFunction *fn=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.timingFunction=fn;
//    animation.byValue=@(200);
    animation.toValue=@(200);
    animation.duration=1.0;

    [scanNet.layer addAnimation:animation forKey:@"scanel"];
    
    
    //开灯和关灯
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setBackgroundImage:[UIImage imageNamed:@"开灯"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"关灯"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(openLightClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@32);
        make.height.equalTo(@37);
        make.centerX.equalTo(self.view);
        make.top.equalTo(scanWindow.bottom).offset(20);
    }];
    
    
    [leftBottom makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(scanWindow);
    }];
    
    [rightBottom makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.bottom.equalTo(scanWindow);
        
    }];
    
    
    [rightTop makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(scanWindow);
    }];
    
    [leftTop makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(scanWindow);
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openLightClick:(UIButton*)sender{
    sender.selected=!sender.selected;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [device lockForConfiguration:nil];
    if (device.torchMode == AVCaptureTorchModeOff) {
        [device setTorchMode: AVCaptureTorchModeOn];
    }else{
        [device setTorchMode: AVCaptureTorchModeOff];
    }
    [device unlockForConfiguration];

    

}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{

    if (metadataObjects.count>0) {
        
        [_session stopRunning];
        [_scanNet.layer removeAllAnimations];
        
        AVMetadataMachineReadableCodeObject *metadataObject=[metadataObjects objectAtIndex:0];
        
        //输出字符串
        NSLog(@"%@",metadataObject.stringValue);
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"扫描输出" message:metadataObject.stringValue delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
        [alert show];
    
    }


    
}

@end
