//
//  KCTmsTestDetailViewController.m
//  KBFuny
//
//  Created by jinlb on 16/4/21.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KCTmsTestDetailViewController.h"
#import "Masonry.h"


@interface KCTmsTestDetailViewController ()

@end



@implementation KCTmsTestDetailViewController

{

    NSString*_data;

}
-(instancetype)initWithData:(NSString *)data title:(NSString *)title
{
    if (self=[super init]) {
        _data=data;
        self.title=title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self  UIInit];
}



-(void)UIInit{

    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UITextView *textview=[UITextView new];
    [self.view addSubview:textview];
    textview.text=_data;
    [textview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    

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
