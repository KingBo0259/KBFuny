//
//  KBCollectionMenuTableViewController.m
//  KBFuny
//
//  Created by jinlb on 2016/12/12.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBCollectionMenuTableViewController.h"

@interface KBCollectionMenuTableViewController ()
@property(nonatomic,strong ,readonly)NSArray*menus;
@property(nonatomic,strong,readonly)NSArray *controllers;
@end

@implementation KBCollectionMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"UICollectView菜单";
    self.view.backgroundColor=[UIColor whiteColor];
    
    //只读属性，内部通过直接访问成员变量进行设置值
    _menus=@[@"UICollection常用Demo",@"FlowLayout应用-五福卡片效果"];
    _controllers=@[@"KBBaseCollectionViewController",@"KBViewlayoutViewController"];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"collectReuseIdentifier"];
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
    return _menus.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectReuseIdentifier"];

    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text=_menus[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    Class class=NSClassFromString(_controllers[indexPath.row]);
    id obj= [class new];
    
    [self.navigationController pushViewController:obj animated:YES];
    
    
}

@end
