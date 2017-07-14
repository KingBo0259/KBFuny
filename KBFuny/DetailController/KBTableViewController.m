//
//  KBTableViewController.m
//  KBFuny
//
//  Created by jinlb on 2017/7/14.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import "KBTableViewController.h"


@interface KBTableViewController ()
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSArray *targetControllers;
@end

@implementation KBTableViewController

- (instancetype)init {
    if (self = [super init]) {
        _titles = @[@"系统下拉刷新",@"cell自动计算高度"];
        _targetControllers = @[@"KBRefreshViewController",@"KBCellHeightTableViewController"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"TableView使用技巧";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"kbTableViewIdentifier"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kbTableViewIdentifier" ];
    cell.textLabel.text =_titles[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - Table view Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Class class = NSClassFromString(_targetControllers[indexPath.row]);
    id    obj   = [class new];
    [self.navigationController pushViewController:obj animated:YES];
}

@end
