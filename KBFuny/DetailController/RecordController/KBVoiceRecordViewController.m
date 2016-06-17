//
//  KBVoiceRecordViewController.m
//  KBFuny
//
//  Created by jinlb on 15/6/5.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import "KBVoiceRecordViewController.h"

@interface KBVoiceRecordViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *recordsImageView;
@end

@implementation KBVoiceRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor clearColor];
    
    
    NSMutableArray *arrary=[[NSMutableArray alloc]init];
    for (int i=0; i<=3; ++i) {
        UIImage *recordImage=[UIImage imageNamed:[NSString stringWithFormat:@"record_%d",i]];
        [arrary addObject:recordImage];
    }
    
    
    _recordsImageView.animationImages=arrary;
    _recordsImageView.animationRepeatCount=0;
    _recordsImageView.animationDuration=2;
    [_recordsImageView startAnimating];
    
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
