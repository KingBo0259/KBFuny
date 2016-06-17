//
//  KCCoredataViewController.m
//  KBFuny
//
//  Created by jinlb on 16/4/28.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KCCoredataViewController.h"
#import "Order+CoreDataProperties.h"
#import "KBCoreDataMananger.h"

#define kManagerObjectContext [KBCoreDataMananger sharedInstance].managedObjectContext
@interface KCCoredataViewController ()
@property (weak, nonatomic) IBOutlet UILabel *orderCountLabel;
@property (weak, nonatomic) IBOutlet UITextField *orderIdTextField;

//新增
@property (weak, nonatomic) IBOutlet UITextField *addOrderIDTextFIield;

@property (weak, nonatomic) IBOutlet UITextField *addOrderNumberTextField;


@end

@implementation KCCoredataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)AddOrderClick:(UIButton*)sender {

    switch (sender.tag) {
        case 1:
        { //增加
            [self addOrder];
        }
            break;
        case 2:{
        //查询
            [self queryOrder];
            
        
        }
            break;
        case 3:{
        //更新
            
            
            
        }
            break;
        case 4:{
        
            //删除
            [self delete];
            
        }
            break;
        default:
            break;
    }

}
-(void)addOrder{

    NSManagedObjectContext *coreDataMananger=[KBCoreDataMananger sharedInstance].managedObjectContext;
    
    Order *order=[NSEntityDescription insertNewObjectForEntityForName:@"Order"
                                               inManagedObjectContext:coreDataMananger];
    
    order.orderId=self.addOrderIDTextFIield.text;
    order.orderNumer=self.addOrderNumberTextField.text;
    [[KBCoreDataMananger sharedInstance] saveContext];

}


-(void)queryOrder
{

    NSFetchRequest *request=[[NSFetchRequest alloc]init];
   NSEntityDescription*entity= [NSEntityDescription entityForName:@"Order" inManagedObjectContext:kManagerObjectContext];

    [request setEntity:entity];
    
    if (_orderIdTextField.text.length>0) {

    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"orderId=%@",_orderIdTextField.text];//@"2016040120102123"
    
        [request setPredicate:predicate];
    }
    
    NSError *error=nil;
    NSArray *result= [kManagerObjectContext executeFetchRequest:request error:&error];
    
    if(result .count==0){
    _orderCountLabel.text=@"未找到结果";
        return;
    }
    //遍历
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Order *order=obj;
        NSLog(@"%@",order.orderNumer);
        
        
    }];
    
    _orderCountLabel.text=[[result firstObject]valueForKey:@"orderNumer"];

}



-(void)delete{

    //先查找
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    NSEntityDescription*entity= [NSEntityDescription entityForName:@"Order" inManagedObjectContext:kManagerObjectContext];
    
    [request setEntity:entity];
    
    
    if (_orderIdTextField.text.length>0) {
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"orderId=%@",_orderIdTextField.text];//@"2016040120102123"
        
        [request setPredicate:predicate];
    }
    
    
    NSError *error=nil;
    NSArray *result= [kManagerObjectContext executeFetchRequest:request error:&error];
    
    if(result .count==0){
        _orderCountLabel.text=@"未找到结果";
        return;
    }
    //遍历
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Order *order=obj;
        
        [kManagerObjectContext deleteObject:obj];

        NSLog(@"%@",order.orderNumer);
        
    }];
    
//    [kManagerObjectContext undo];
    _orderCountLabel.text=@"删除成功";

    
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
