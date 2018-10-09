//
//  KBAutoScrollerViewController.m
//  KBFuny
//
//  Created by jinlb on 2018/10/9.
//  Copyright © 2018年 jinlb. All rights reserved.
//

#import "KBAutoScrollerViewController.h"

@interface KBAutoScrollerViewController ()
@property(nonatomic,assign) CGFloat  oneHeight;
@property(nonatomic,assign) CGFloat  twoHeight;
@property(nonatomic,assign) CGFloat  threeHeight;
@property(nonatomic,assign) CGFloat  fourHeight;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIView *containerView;
@property(nonatomic,strong) UILabel *oneLabel;
@property(nonatomic,strong) UILabel *twoLabel;
@property(nonatomic,strong) UILabel *threeLabel;
@property(nonatomic,strong) UILabel *fourLabel;

@end

@implementation KBAutoScrollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"scroller 自动布局";
    self.view.backgroundColor =[UIColor whiteColor];
    
    self.scrollView = [UIScrollView new];
    self.scrollView.backgroundColor = [UIColor yellowColor];
    _containerView = [UIView new];
    _containerView.backgroundColor =[UIColor grayColor];
    _oneLabel = [UILabel new];
    _oneLabel.backgroundColor = [UIColor greenColor];
    _twoLabel = [UILabel new];
    _threeLabel = [UILabel new];
    _threeLabel.backgroundColor = [UIColor redColor];
    _fourLabel = [UILabel new];
    _fourLabel.backgroundColor = [UIColor flatGrayColor];
    
    self.oneHeight = 0;
    self.twoHeight = 0;
    self.threeHeight = 0;
    self.fourHeight = 0;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.containerView];
    [self.containerView addSubview:self.oneLabel];
    [self.containerView addSubview:self.twoLabel];
    [self.containerView addSubview:self.threeLabel];
    [self.containerView addSubview:self.fourLabel];
    
    [self.view setNeedsUpdateConstraints];
    
    // 模拟3s后网络请求数据回来了，oneLabel根据数据获得了高度。
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.oneHeight = 180;
        [self.view setNeedsUpdateConstraints];
    });
    
    // 模拟6s后网络请求数据回来了，fourLabel根据数据获得了高度。
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.fourHeight = 100;
        [self.view setNeedsUpdateConstraints];
    });
    
    // 模拟9s后网络请求数据回来了，twoLabel根据数据获得了高度。
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.twoHeight = 250;
        [self.view setNeedsUpdateConstraints];
    });
    
    // 模拟12s后网络请求数据回来了，threeLabel根据数据获得了高度。
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(12 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.threeHeight = 160;
        [self.view setNeedsUpdateConstraints];
    });
}

- (void)updateViewConstraints {
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    [self.oneLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView).offset(50);
        make.left.right.equalTo(self.containerView);
        make.height.equalTo(@(self.oneHeight));
    }];
    
    [self.twoLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.oneLabel.mas_bottom);
        make.left.right.equalTo(self.containerView);
        make.height.equalTo(@(self.twoHeight));
    }];
    
    [self.threeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twoLabel.mas_bottom);
        make.left.right.equalTo(self.containerView);
        make.height.equalTo(@(self.threeHeight));
    }];
    
    [self.fourLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.threeLabel.mas_bottom);
        make.left.right.equalTo(self.containerView);
        make.height.equalTo(@(self.fourHeight));
        make.bottom.equalTo(self.containerView);
    }];
    
    [super updateViewConstraints];
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
