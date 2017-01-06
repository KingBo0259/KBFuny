//
//  MasterViewController.m
//  KBFuny
//
//  Created by jinlb on 15/2/27.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "KCStartAnimation.h"
#import "KCUserNavigationView.h"
#import "KBTouchTableView.h"
#import "SKYBase64.h"


@interface MasterViewController ()<TouchTableViewDelegate>

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self dataInit];
    
    
    NSString *encode=[SKYBase64 base64StringFromText:@"123456"];
    NSString *decodeStr=[SKYBase64 textFromBase64String:encode];
    NSString *value=decodeStr;
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
    //    backItem.title=self.title?self.title:self.navigationItem.title;
    backItem.title=@"";
    self.navigationItem.backBarButtonItem=backItem;
    
    //返回图标更改
     [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"back" ]];
     [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back" ]];
    
    //滑动时隐藏bar
    self.navigationController.hidesBarsOnSwipe=YES;
    [self testStringCompare];
    
    //导航条返回键带的title太讨厌了,怎么让它消失!
//    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(0,-60) forBarMetrics:UIBarMetricsDefault];
    return;
    KBTouchTableView *touchTablveView=[[KBTouchTableView alloc]init];
    
    touchTablveView.frame=self.view.frame;
    
    touchTablveView.touchTableViewDelegate=self;
    
    touchTablveView.backgroundColor=[UIColor redColor];
    
    touchTablveView.center=CGPointMake(0, self.view.frame.size.height/2);
    
    [self.view addSubview:touchTablveView];
    
   
}


-(void)testStringCompare{

    NSString *version1=@"4.2.6";
    NSString *version2=@"4.1.4.2";

    if ([version1 compare:version2]==NSOrderedDescending) {
        NSLog(@"big:%@",version1);
    }else{
    
        NSLog(@"big:%@",version2);

    }
}

-(void)testUserNavigation{

    
    KCUserNavigationView *userView=[[KCUserNavigationView alloc]init];
    [self.navigationController.view addSubview:userView];
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    UIView *startView=  [[KCStartAnimation alloc]init];
    [self.navigationController.view addSubview:startView];
    
    
    
    
}
-(void)navigationAnimation:(NSString*)animaionType{

    
    /* type
     
     animation.type = kCATransitionFade;
     animation.type = kCATransitionPush;
     animation.type = kCATransitionReveal;
     animation.type = kCATransitionMoveIn;
     animation.type = @"cube";
     animation.type = @"suckEffect";
     // 页面旋转
     animation.type = @"oglFlip";
     //水波纹
     animation.type = @"rippleEffect";
     animation.type = @"pageCurl";
     animation.type = @"pageUnCurl";
     animation.type = @"cameraIrisHollowOpen";
     animation.type = @"cameraIrisHollowClose"
     */
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = animaionType;
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}
-(void)dataInit
{
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] initWithObjects:
                        @"Core-Animation-三"
                        ,@"Core-Animation"
                        ,@"设备操作"
                        ,@"CAMediaTiming"
                        ,@"阿里云盘测试"
                        ,@"Hessian Test"
                        ,@"对象归档"
                        ,@"ZBar"
                        ,@"录音UI制作"
                        ,@"自定义控件"
                        ,@"高德导航测试"
                        ,@"TableView下拉刷行"
                        ,@"ObjectiveC"
                        ,@"GrandCenterDispatch"
                        ,@"KCNetworkframework"
                        ,@"OperationQueue And Other "
                        ,@"ShaperLayer1"
                        ,@"CoreData"
                        ,@"Facebook Pop"
                        ,@"KBScriptViewController"
                        ,@"UICollection 学习"
                        , nil];
    }

 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
  
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell%ld",(long)indexPath.row] forIndexPath:indexPath];
    
    
    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark - TouchTableViewDelegate
- (void)tableView:(UITableView *)tableView touchesBegin:(NSSet *)touches withEvent:(UIEvent *)event{

}
- (void)tableView:(UITableView *)tableView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{

    NSLog(@"Cancel");
}
- (void)tableView:(UITableView *)tableView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

}
- (void)tableView:(UITableView *)tableView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    NSLog(@"Moved");
    
    //通过 point 和 ptPrevious 的坐标判断 是向左向右 向下向上
    for (UITouch *touch in [event allTouches]) {
        if (touch.phase == UITouchPhaseStationary) {
            continue;
        }
        CGPoint point=[touch locationInView:self.view];
        NSLog(@"x=%li;y=%li",(long)point.x,(long)point.y);

        CGPoint ptPrevious=[touch previousLocationInView:self.view];
        
        NSLog(@"px=%li;py=%li",(long)ptPrevious.x,(long)ptPrevious.y);
        
        
        tableView.center=CGPointMake(tableView.center.x+(point.x-ptPrevious.x), tableView.center.y);
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row==2) {
        
        Class class=NSClassFromString(@"KBDeviceMenuTableViewController");
        id obj=[class new];
        [self.navigationController pushViewController:obj animated:YES];
        
    }else if (indexPath.row==11) {
        //1、 设置动画
        [self navigationAnimation:@"cameraIrisHollowClose"];
        
        Class class=NSClassFromString(@"KBRefreshViewController");
        id obj=[class new];
        [obj performSelector:NSSelectorFromString(@"isON")];
        [self.navigationController pushViewController:obj animated:YES];
    }else if (indexPath.row==12){
        //1、 设置动画
        [self navigationAnimation:@"cameraIrisHollowOpen"];
        
        Class class=NSClassFromString(@"KBObjectiveCViewController");
        id obj=[class new];
        [self.navigationController pushViewController:obj animated:YES];

    }else if(indexPath.row==13){
        //1、 设置动画
        [self navigationAnimation:@"pageUnCurl"];
        
    
        Class class=NSClassFromString(@"KBCrandCenterDispatchViewController");
        id obj=[class new];
        [self.navigationController pushViewController:obj animated:YES];

    }else if(indexPath.row==14){
        //1、 设置动画
        [self navigationAnimation:@"pageCurl"];

        Class class=NSClassFromString(@"KCNetworkFrameworkDemoViewController");
        id obj=[class new];
        [self.navigationController pushViewController:obj animated:YES];
    }else if (indexPath.row==15){
        //1、 设置动画

        [self navigationAnimation:@"cube"];

        Class class=NSClassFromString(@"KCOperationViewController");
        id obj=[class new];
        [self.navigationController pushViewController:obj animated:YES];

    }else if (indexPath.row==16){
        
        //1、 设置动画
        [self navigationAnimation:@"suckEffect"];
        
        Class class=NSClassFromString(@"KBShaperTableViewController");
        id obj=[class new];
        [self.navigationController pushViewController:obj animated:YES];

    }else if (indexPath.row==17){
        //1、 设置动画
        [self navigationAnimation:@"rippleEffect"];//水波纹
        
        Class class=NSClassFromString(@"KCCoreDataMenuTableViewController");
        id obj=[class new];
        [self.navigationController pushViewController:obj animated:YES];

        
    }else if (indexPath.row==18){
        
        //FaceBook Pod
        Class class=NSClassFromString(@"KBPodMenuTableViewController");
        id obj=[class new];
        [self.navigationController pushViewController:obj animated:YES];
        

    }else if (indexPath.row==19){
    
        //FaceBook Pod
        Class class=NSClassFromString(@"KBScriptViewController");
        id obj=[class new];
        [self.navigationController pushViewController:obj animated:YES];
        

    }else if (indexPath.row==20){
    
        //KBCollectionMenuTableViewController
        Class class=NSClassFromString(@"KBCollectionMenuTableViewController");
        id obj=[class new];
        [self.navigationController pushViewController:obj animated:YES];
        

    }
}

@end
