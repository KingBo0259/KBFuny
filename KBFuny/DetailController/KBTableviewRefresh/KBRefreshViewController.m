//
//  KBRefreshViewController.m
//  KBFuny
//
//  Created by jinlb on 15/12/2.
//  Copyright © 2015年 jinlb. All rights reserved.
//

#import "KBRefreshViewController.h"
//#import <KCNetWorkProxy/KCNetWorkProxy.h>
//#import <KCNetWorkProxy/KCHessianFactory.h>
//#import <KCNetWorkProxy/KCClientInfo.h>
#import <CommonCrypto/CommonDigest.h>

#import "SVProgressHUD.h"

NSString* const KBRefreshViewControlStr=@"KBRefreshViewControlStr";




@interface KBRefreshViewController ()<UIActionSheetDelegate>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIRefreshControl *refreshControl;

@end

@implementation KBRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    
    [self UIInit];
}

-(void)UIInit{

    
    UIView *testView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    testView.backgroundColor=[UIColor redColor];
    
    testView.center=CGPointMake(120, 0);

    self.refreshControl=[UIRefreshControl new];
    self.refreshControl.backgroundColor=[UIColor yellowColor];
    self.refreshControl.layer.masksToBounds=YES;

    [self.refreshControl addSubview:testView];
    [self.refreshControl addTarget:self action:@selector(refreshEvent) forControlEvents:UIControlEventValueChanged];

    self.refreshControl.attributedTitle=[[NSAttributedString alloc]initWithString:@"下拉刷新数据"];;
    self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableview.frame.size.width, 100)];
    headerView.backgroundColor=[UIColor  whiteColor];
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"actionSheet" forState:UIControlStateNormal];
    button.frame=CGRectMake(100, 10, 100, 40);
    button.tag=1;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:button];
    
    
    button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"系统自带share" forState:UIControlStateNormal];
    button.frame=CGRectMake(160, 60, 200, 40);
    button.tag=2;
    [button addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:button];
    
    

    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 100, 200, 50)];
    lable.textColor=[UIColor blackColor];
    NSString *str=@"我是中间划线测试！";
    NSMutableAttributedString *attribute= [[NSMutableAttributedString alloc]initWithString:str];
    //添加中间划线
    [attribute addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, str.length)];
    
    //添加下划线
    [attribute addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, str.length)];
    
    lable.attributedText=attribute;
    [headerView addSubview:lable];

    
    button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"SVProcess" forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 60, 100, 40);
    button.tag=3;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:button];
    
    

    
    
    
    self.tableview.tableHeaderView=headerView;
    [self.tableview addSubview:self.refreshControl];

    
    [self.view addSubview:self.tableview];
//    [self.refreshControl beginRefreshing];
}



- (IBAction)shareAction:(id)sender {
    
    NSString *textToShare =@"我是kingbo博客。";
    
    UIImage *imageToShare = [UIImage imageNamed:@"联系人"];
    
    NSURL *urlToShare = [NSURL URLWithString:@"http://www.iosbook3.com"];
    
    NSArray *activityItems = @[textToShare, imageToShare, urlToShare];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems
                                            
                                                                            applicationActivities:nil];
    
    //不出现在活动项目
    
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
                                         
                                         UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    
    [self presentViewController:activityVC animated:TRUE completion:nil];
    
}

-(void)showAlertController{

    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"测试" message:@"我是测试" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"click 确定");

    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       textField.placeholder=@"最大可输入350元";
    }];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];

}


-(void)buttonClick:(UIButton*)sender{
    if (sender.tag==1) {
    //添加action sheet
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"选择加价金额" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"20元",@"30元", nil];
    actionSheet.actionSheetStyle=UIBarStyleBlackTranslucent;
//    [actionSheet  addButtonWithTitle:@"test"];
        
    
    
    [actionSheet showInView:self.view];
    }else if(sender.tag==2){
        
        [self  showAlertController];

    
    }else if (sender.tag==3){
    
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//        [SVProgressHUD show];
        [SVProgressHUD showErrorWithStatus:@"错误信息"];
    }
    

    

}


-(BOOL)isON{

    NSLog(@"我是自定义的ON");
    return _on;
}

//MD5加密
- (NSString *)md5HexDigest:(NSString*)password
{
    const char *str= [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    
    NSLog(@"===========%@",ret.lowercaseString);
    return ret.lowercaseString;
    
}

-(void)refreshEvent{
    NSLog(@"refreshEvent");

    [self.refreshControl endRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    NSLog(@"click:%li",(long)buttonIndex);

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
