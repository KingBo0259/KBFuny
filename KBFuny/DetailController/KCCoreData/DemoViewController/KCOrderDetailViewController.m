//
//  KCOrderDetailViewController.m
//  KBFuny
//
//  Created by jinlb on 16/5/4.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KCOrderDetailViewController.h"

@interface KCOrderDetailViewController ()

@end

@implementation KCOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"订单明细";
    
   [self hideKeyboardWhenBackgroundIsTapped];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)hideKeyboardWhenBackgroundIsTapped{

    UITapGestureRecognizer *tgr=[[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(hidenKeyBord)];
    
    [tgr setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tgr];

}

-(void)hidenKeyBord{


    [self.view endEditing:YES];

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
