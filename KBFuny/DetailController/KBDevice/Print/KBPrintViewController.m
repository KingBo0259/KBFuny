//
//  KBPrintViewController.m
//  KBFuny
//
//  Created by jinlb on 2016/11/10.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBPrintViewController.h"
#import "Masonry.h"
#import "KBPrintPageRenderer.h"
#import "RecipePrintPageRenderer.h"

@interface KBPrintViewController ()

@end

@implementation KBPrintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeInfoDark];
    [button setTitle:@"用printItem(s) 打印" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(setPrintClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *printFormatterButton=[UIButton buttonWithType:UIButtonTypeInfoDark];
    [printFormatterButton setTitle:@"用printFormatterButton打印" forState:UIControlStateNormal];
    [printFormatterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [printFormatterButton addTarget:self action:@selector(printFormatterClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:printFormatterButton];
    
    
    
    UIButton *printPageRenderer=[UIButton buttonWithType:UIButtonTypeInfoDark];
    [printPageRenderer setTitle:@"用printPageRenderer打印" forState:UIControlStateNormal];
    [printPageRenderer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [printPageRenderer addTarget:self action:@selector(printPageRendererClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:printPageRenderer];

    
    
    [button makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@300);
        make.height.equalTo(@40);
        make.top.equalTo(self.view).offset(80);
        make.left.equalTo(self.view).offset(10);

    }];
    
    
    [printFormatterButton makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.left.equalTo(button);
        make.top.equalTo(button.bottom).offset(10);
    }];
    
    [printPageRenderer makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.left.equalTo(printFormatterButton);
        make.top.equalTo(printFormatterButton.bottom).offset(10);
    }];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark  --Event

-(void)printPageRendererClick:(id)sener{

    /*=======> UIPrintInfo=========***/
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.jobName = @"iOS测试打印";//此打印任务的名称。这个名字将被显示在设备的打印中心，对于有些打印机则显示在液晶屏上。
    
    /*outputType
     .General （默认）：文本和图形混合类型；允许双面打印。
     .Grayscale ：如果你的内容只包括黑色文本，那么该类型比 .General 更好。
     .Photo ：彩色或黑白图像；禁用双面打印，更适用于图像媒体的纸张类型。
     .PhotoGrayscale ：对于仅灰度的图像，根据打印机的不同，该类型可能比 .Photo 更好。
     
     */
    printInfo.outputType = UIPrintInfoOutputGeneral;
    //        printInfo.printerID=@"";//一个特定的打印机的 ID，当用户通过 UI 选择过打印机并且保存它作为未来打印预设 之后 ，你才能得到这个类型。
    
    /*=======> UIPrintInteractionController=========***/
    UIPrintInteractionController *printController = [UIPrintInteractionController sharedPrintController];
    printController.printInfo = printInfo;
    
    Recipe *recipe=[[Recipe alloc]init];
    recipe.html=@"<h1>我是printFormater打印</h1>";
    RecipePrintPageRenderer *pageRederer=[[RecipePrintPageRenderer alloc]initWithAuthorName:@"PageRender" recipe:recipe];
    printController.printPageRenderer =pageRederer;
    
    [printController presentAnimated:true completionHandler: nil];
}

-(void)printFormatterClick:(id)sender{
    
    
    /*=======> UIPrintInfo=========***/
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.jobName = @"iOS测试打印";//此打印任务的名称。这个名字将被显示在设备的打印中心，对于有些打印机则显示在液晶屏上。
    
    /*outputType
     .General （默认）：文本和图形混合类型；允许双面打印。
     .Grayscale ：如果你的内容只包括黑色文本，那么该类型比 .General 更好。
     .Photo ：彩色或黑白图像；禁用双面打印，更适用于图像媒体的纸张类型。
     .PhotoGrayscale ：对于仅灰度的图像，根据打印机的不同，该类型可能比 .Photo 更好。
     
     */
    printInfo.outputType = UIPrintInfoOutputGeneral;
    //        printInfo.printerID=@"";//一个特定的打印机的 ID，当用户通过 UI 选择过打印机并且保存它作为未来打印预设 之后 ，你才能得到这个类型。
    
    /*=======> UIPrintInteractionController=========***/
    UIPrintInteractionController *printController = [UIPrintInteractionController sharedPrintController];
    printController.printInfo = printInfo;
    
    UIMarkupTextPrintFormatter *formatter = [[UIMarkupTextPrintFormatter alloc] initWithMarkupText:@"<div style='color:#00FF00;background-color: red;'><h1>我是printFormater打印</h1></div>"];
    formatter.contentInsets = UIEdgeInsetsMake(72, 72, 72, 72); // 1" margins
    
    
    
    printController.printFormatter =formatter;
    
    [printController presentAnimated:true completionHandler: nil];

    
}

//Item打印
-(void)setPrintClick:(id)sender{
    NSData *data=UIImagePNGRepresentation([UIImage imageNamed:@"樱花树3"]);;
    if ([UIPrintInteractionController canPrintData:data]) {
        
        
        /*=======> UIPrintInfo=========***/
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        printInfo.jobName = @"iOS测试打印";//此打印任务的名称。这个名字将被显示在设备的打印中心，对于有些打印机则显示在液晶屏上。
        
        /*outputType
         .General （默认）：文本和图形混合类型；允许双面打印。
         .Grayscale ：如果你的内容只包括黑色文本，那么该类型比 .General 更好。
         .Photo ：彩色或黑白图像；禁用双面打印，更适用于图像媒体的纸张类型。
         .PhotoGrayscale ：对于仅灰度的图像，根据打印机的不同，该类型可能比 .Photo 更好。

         */
        printInfo.outputType = UIPrintInfoOutputGeneral;
//        printInfo.printerID=@"";//一个特定的打印机的 ID，当用户通过 UI 选择过打印机并且保存它作为未来打印预设 之后 ，你才能得到这个类型。
        
        /*=======> UIPrintInteractionController=========***/
        UIPrintInteractionController *printController = [UIPrintInteractionController sharedPrintController];
        printController.printInfo = printInfo;
        
        printController.printingItem =data;
        
        [printController presentAnimated:true completionHandler: nil];
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
