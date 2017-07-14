//
//  KBCellHeightTableViewController.m
//  KBFuny
//
//  Created by jinlb on 2017/7/14.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import "KBCellHeightTableViewController.h"
#import "KBAutoTableViewCell.h"

@interface KBCellHeightTableViewController ()
@property (nonatomic,strong) NSArray *dataSources;
@end

@implementation KBCellHeightTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSources = @[@"一行",
                     @"两行\n两行",
                     @"你的饭啊发大发大发罚单发大发罚单大发发大发大发罚单阿凡达啊的阿凡达发发发发的方法罚单发",
                     @"你的饭啊发大发大发罚单发大发罚单大发发大发大发罚单阿凡达啊的阿凡达发发发发的方法罚单发\n第四行",
                     @"你的饭啊发大发大发罚单发大发罚单大发发大发大发罚单阿凡达啊的阿凡达发发发发的方法罚单发\n第7行\n第7行\n第7行\n第7行",
                     @"你的饭啊发大发大发罚单发大发罚单大发发大发大发罚单阿凡达啊的阿凡达发发发发的方法罚单发\n第10行\n第10行\n第10行\n第10行\n第10行\n第10行\n第10行",
                     @"银行"
                    ];
    
    self.title = @"cell自动高度";
    self.tableView.rowHeight = 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    KBAutoTableViewCell *temlCell =  [[[NSBundle mainBundle] loadNibNamed:@"KBAutoTableViewCell" owner:self options:nil] lastObject];
    temlCell.myTitle.text =_dataSources[indexPath.row];
    //这里需要缓存高度
    [temlCell layoutIfNeeded];
    CGFloat height = temlCell.okButton.frame.origin.y + temlCell.okButton.frame.size.height + 8.0;
    NSLog(@"myTitleHeight:%f",temlCell.myTitle.bounds.size.height);
    return height;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"KBAutoTableViewCell";
    KBAutoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier ];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
    }
    cell.myTitle.text = _dataSources[indexPath.row];
    cell.layer.masksToBounds = YES;
    return cell;
}


@end
