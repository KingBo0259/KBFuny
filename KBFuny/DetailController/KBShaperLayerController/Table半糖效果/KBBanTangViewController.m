//
//  KBBanTangViewController.m
//  KBFuny
//
//  Created by jinlb on 2016/12/28.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBBanTangViewController.h"
@interface KBBanTangViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation KBBanTangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initUI{

    self.tableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellReuseIdentifier"];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  -  UITableviewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    return nil;
}

@end
