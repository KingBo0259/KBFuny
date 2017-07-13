//
//  KBSpinnyMcSpinfaceViewController.m
//  KBFuny
//
//  Created by jinlb on 2017/7/13.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import "KBSpinnyMcSpinfaceViewController.h"
#import "KBSpinnyMcSpinface.h"

@interface KBSpinnyMcSpinfaceViewController ()

@end

@implementation KBSpinnyMcSpinfaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.title = @"CAShaplyer 螺旋效果";
    KBSpinnyMcSpinface *shaper = [[KBSpinnyMcSpinface alloc] initWithNumberOfItems:10];
    shaper.backgroundColor = [UIColor yellowColor].CGColor;
    [self.view.layer addSublayer:shaper];
    
    [shaper startAnimation];
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
