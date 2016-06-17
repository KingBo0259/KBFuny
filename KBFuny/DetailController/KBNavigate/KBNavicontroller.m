//
//  KBNavicontroller.m
//  KBFuny
//
//  Created by jinlb on 15/6/26.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import "KBNavicontroller.h"

#import "KBSecondViewController.h"
#import "KBGaodeViewController.h"
#import "PopoverView.h"
#import "KBPopoverView.h"
#import "TonightSlider.h"
#import "KTMSAutoSearchDataView.h"
#import "UITextField+BSErrorMessageView.h"


@interface KBNavicontroller()<KTMSAutoSearchDataDelegate >
@property (weak, nonatomic) IBOutlet UITextField *searchText;

@end

@implementation KBNavicontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.searchText bs_setupErrorMessageViewWithMessage:@"数据错了"];
    [self.searchText bs_showError];
    
    TonightSlider *toSlider=[[TonightSlider alloc]initWithFrame:CGRectMake(0, 100, 100, 60)];
    [self.view addSubview:toSlider];
    
    
    
}
- (IBAction)navigateClick:(UIButton*)sender {
    
    if ([[sender valueForKey:@"tag"] integerValue]==0) {
        self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(goBack:)];
        
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"首页" style:UIBarButtonItemStyleBordered  target:self action:@selector(goBack:)];
        
        [self.navigationController pushViewController:[KBSecondViewController new] animated:NO];//这样可以实现多集跳转
        
        [self.navigationController pushViewController:[KBGaodeViewController new] animated:NO];
        
        
//        [self.navigationController pushViewController:[KBAliyunViewController new] animated:YES];
    }else if ( [[sender valueForKey:@"tag"] integerValue]==1){
        
        __weak  UIButton *btn=(UIButton *)sender;
   [PopoverView showPopoverAtPoint:CGPointMake(btn.center.x, btn.center.y+100) inView:self.view withText:@"ttatafafadffadfadfafafasfasfadfafafasfasfsdfest" delegate:nil];

    
    }else if ([[sender valueForKey:@"tag"] integerValue]==2){
    
//        KBPopoverView *popoverView=[KBPopoverView showPopoverWithFrame:CGRectMake(10, 100, 300, 200) WithContextView:nil];
        
//        KBPopoerView *popoverView=[[KBPopoerView alloc] initWithFrame:CGRectMake(10, 50, 200, 100)];
//        [self.view addSubview:popoverView];
    }else if ([[sender valueForKey:@"tag"] integerValue]==10){
        
        //自己的位置
       CGPoint positon= [sender convertPoint:CGPointMake(0, 0) toView:self.view];
        NSLog(@"after:%f,%f",positon.x,positon.y);

        
        if(!_autoSearchDataView){
            _autoSearchDataView=[[KTMSAutoSearchDataView alloc]initWithPosition:CGPointMake(positon.x, positon.y+sender.frame.size.height+2) inParentView:self.view];
        };
        [_autoSearchDataView showWithSearchKey:@""];
        
    }
    
}

-(void)goBack:(id)sender{
    NSLog(@"goBack");
    [self.navigationController popViewControllerAnimated:YES];

}



#pragma mark - UITextViewDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    //自己的位置
    CGPoint positon= [textField convertPoint:CGPointMake(0, 0) toView:self.view];
    NSLog(@"after:%f,%f",positon.x,positon.y);

    CGPoint searchViewPosition=CGPointMake(positon.x, positon.y+textField.frame.size.height+2);
    if(!_autoSearchDataView){
        _autoSearchDataView=[[KTMSAutoSearchDataView alloc]initWithPosition:searchViewPosition inParentView:self.view];
        _autoSearchDataView.delegate=self;
    };
    
    [_autoSearchDataView setViewPosition:searchViewPosition];
    
    [_autoSearchDataView showWithSearchKey:textField.text];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    NSString *searchKey=[textField.text stringByReplacingCharactersInRange:range withString:string];
    [_autoSearchDataView showWithSearchKey:searchKey];

    return YES;

}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [_autoSearchDataView hide];
}

#pragma mark -  KTMSAutoSearchDataDelegate
-(void)searchView:(KTMSAutoSearchDataView *)searchView didSelectRow:(NSString *)selectRow{

    self.searchText.text=selectRow;
    [self.searchText resignFirstResponder];

}

@end
