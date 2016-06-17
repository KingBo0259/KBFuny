//
//  KTMSAutoSearchDataView.m
//  KBFuny
//
//  Created by jinlb on 16/5/13.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KTMSAutoSearchDataView.h"
#import "Masonry.h"

static CGFloat defualtWith=200.0f;
static CGFloat cellHeight=44.0f;

@interface KTMSAutoSearchDataView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation KTMSAutoSearchDataView{


    __weak UIView *_parentView;
    NSMutableArray *_dataSource;
    UITableView *_tableView;
}

#pragma mark - 构造函数
-(instancetype)initWithPosition:(CGPoint)position inParentView:(UIView*)parentView{

    if (self=[self initWithPosition:position width:defualtWith inParentView:parentView]) {
        
    }
    return self;
}
-(instancetype)initWithPosition:(CGPoint)position width:(CGFloat)width inParentView:(UIView*)parentView{

    if (self=[super init]) {
        self.frame=CGRectMake(position.x, position.y, width, 0);//高度是由于
        _parentView=parentView;
        [_parentView addSubview:self];
        
        [self initUI];
        
        
       
    }
    return self;
}


-(void)initUI{
    //背景
    self.backgroundColor=[UIColor redColor];
    self.hidden=YES;
    
    self.layer.cornerRadius=5.0f;
    self.layer.shadowRadius=5.0f;
    self.layer.shadowOffset = CGSizeMake(0, 2); //设置阴影的偏移量
    self.layer.shadowColor = [UIColor blackColor].CGColor; //设置阴影的颜色为黑色
    self.layer.shadowOpacity = 0.6; //设置阴影的不透明度
    

    _tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    

}

-(void)setViewPosition:(CGPoint)position{

    self.frame=CGRectMake(position.x,position.y, self.frame.size.width, self.frame.size.height);


}
-(void)showWithSearchKey:(NSString*)searchKey{

    self.hidden=NO;
    
    [ self searDataWithSearchKey:searchKey];

}
//搜索
-(void)searDataWithSearchKey:(NSString*)searchKey{

    
    //1、 获取数据源(可以是本地、也可以是网络请求
    //这里是测试数据
     _dataSource=[[NSMutableArray alloc]initWithObjects:@"A",@"search2",@"B",@"Action",@"mayLayDay",@"hellop", nil];
 
    if (searchKey.length>0) {
        NSPredicate *sPredicate = [NSPredicate predicateWithFormat:[ NSString stringWithFormat:@"SELF contains[c]  '%@'",searchKey ]];
        [_dataSource filterUsingPredicate:sPredicate];
        
    }
   
    
    //2、设置框高度
    [self setHightWithDataCount:_dataSource.count];
    
    //3、重新加载数据
    [_tableView reloadData];


}


-(void)hide{
    self.hidden=YES;
}

-(void)setHightWithDataCount:(NSInteger)dataCout{
    
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, dataCout*cellHeight);
}
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return cellHeight;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataSource?_dataSource.count:0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  static NSString*cellIndentifer=@"autoSearchCellIdentifer";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndentifer];
    
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifer];
        
    }
    cell.textLabel.text=_dataSource[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //1、委托数据源
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(searchView:didSelectRow:)]){
        [self.delegate searchView:self didSelectRow:_dataSource[indexPath.row]];
    }
    
    //2、隐藏
    [self hide];
    

}

@end
