//
//  KBViewlayoutViewController.m
//  KBFuny
//
//  Created by jinlb on 2016/12/13.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBViewlayoutViewController.h"
#import "KBBaseCollectionViewCell.h"
#import "KBFowLayout.h"

@interface KBViewlayoutViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak) UICollectionView *collectionView;

@end

@implementation KBViewlayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"FlowLayout应用";
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self initUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initUI{
    
    self.automaticallyAdjustsScrollViewInsets=YES;
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[KBFowLayout new]];
    
    self.collectionView=collectionView;
    collectionView.backgroundColor=[UIColor whiteColor];
    
    collectionView.delegate=self;
    collectionView.dataSource=self;
    
    [collectionView registerClass:[KBBaseCollectionViewCell class] forCellWithReuseIdentifier:@"collectionReuseIdentifier"];
    
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    
    [self.view addSubview:collectionView];
    
    
    [collectionView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        
        make.top.equalTo(@100);
        
        make.height.equalTo(@120);//高度布局
    }];
    
    
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return 20;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KBBaseCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionReuseIdentifier" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor redColor];
    cell.botTitleLabel.text=[NSString stringWithFormat:@"第%li项",indexPath.row];
    return  cell;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    KBBaseCollectionViewCell *cell = (KBBaseCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%@",cell);
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
