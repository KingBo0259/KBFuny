//
//  KCOrderListTVC.m
//  KBFuny
//
//  Created by jinlb on 16/5/3.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KCOrderListTVC.h"
#import "KBCoreDataMananger.h"
#import "Order.h"
@interface KCOrderListTVC ()

@end

@implementation KCOrderListTVC


#pragma mark - VIEW
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    
    [self congfigureFetch];
    [self performFetch];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(performFetch) name:@"SomethingChanged" object:nil];
    
}

-(void)initUI{

    UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addOrderClick:)];
    
    self.navigationItem.rightBarButtonItem=rightBarItem;

}

-(void)addOrderClick:(id)sender{

   Class class=NSClassFromString(@"KCOrderDetailViewController");
    id obj=[class new];
    [self.navigationController pushViewController:obj animated:YES];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    static NSString*cellIdentifer=@"orderCell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifer];
        cell.accessoryType=UITableViewCellAccessoryDetailButton;
        
    }
    
    Order *order=[self.frc objectAtIndexPath:indexPath];
    
    cell.textLabel.text=order.orderId;
    return cell;

}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle==UITableViewCellEditingStyleDelete) {
        Order *order=[self.frc objectAtIndexPath:indexPath];
        [self.frc.managedObjectContext deleteObject:order];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark DATA

-(void)congfigureFetch{
    KBCoreDataMananger *dataMananger=[KBCoreDataMananger sharedInstance];
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Order"];
    [request setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"orderNumer" ascending:YES]]];
    
    self.frc=[[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:dataMananger.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.frc.delegate=self;

    
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
