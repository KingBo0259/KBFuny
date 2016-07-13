//
//  KBShaperTableViewController.m
//  KBFuny
//
//  Created by jinlb on 16/7/12.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBShaperTableViewController.h"
#import "KBShaperLayerController.h"

@interface KBShaperTableViewController ()
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray*detailControllers;
@end

@implementation KBShaperTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"CALayer 效果案例";
    self.titles=@[@"模态/遮罩/边框/粒子效果",@"Mask"];
    self.detailControllers=@[@"KBShaperLayerController",@"KBShaperLayerDemoViewController"];
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
    return self.titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString*  const identiferCell=@"identiferCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identiferCell];

    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identiferCell];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text=self.titles[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    Class class=NSClassFromString(self.detailControllers[indexPath.row]);
    id obj=[class new];

    [self.navigationController pushViewController:obj animated:YES];
    
    

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
