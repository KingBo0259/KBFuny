//
//  KBPodMenuTableViewController.m
//  KBFuny
//   这里是FaceBook Pod利用案例
//  Created by jinlb on 16/9/8.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBPodMenuTableViewController.h"
#import "POP.h"


@interface KBPodMenuTableViewController ()
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray*controllers;
@end

@implementation KBPodMenuTableViewController

-(instancetype)init
{
    if (self=[super init]) {
        _titles=@[@"基本使用"];
        self.controllers=@[@"KBPOPBasicAnimationViewController"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"FaceBook POP使用";
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
   
    [self facebookPOP];
}


-(void)facebookPOP{
    
    // 1. Pick a Kind Of Animation //  POPBasicAnimation  POPSpringAnimation POPDecayAnimation
    POPSpringAnimation *basicAnimation = [POPSpringAnimation animation];
    
    // 2. Decide weather you will animate a view property or layer property, Lets pick a View Property and pick kPOPViewFrame
    // View Properties - kPOPViewAlpha kPOPViewBackgroundColor kPOPViewBounds kPOPViewCenter kPOPViewFrame kPOPViewScaleXY kPOPViewSize
    // Layer Properties - kPOPLayerBackgroundColor kPOPLayerBounds kPOPLayerScaleXY kPOPLayerSize kPOPLayerOpacity kPOPLayerPosition kPOPLayerPositionX kPOPLayerPositionY kPOPLayerRotation kPOPLayerBackgroundColor
    basicAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    
    // 3. Figure Out which of 3 ways to set toValue
    //  anim.toValue = @(1.0);
    //  anim.toValue =  [NSValue valueWithCGRect:CGRectMake(0, 0, 400, 400)];
    //  anim.toValue =  [NSValue valueWithCGSize:CGSizeMake(40, 40)];
    basicAnimation.toValue=[NSValue valueWithCGRect:CGRectMake(0, 0, 160, 320)];
    
    // 4. Create Name For Animation & Set Delegate
    basicAnimation.name=@"AnyAnimationNameYouWant";
    basicAnimation.delegate=self;
    
    // 5. Add animation to View or Layer, we picked View so self.tableView and not layer which would have been self.tableView.layer
    [self.tableView pop_addAnimation:basicAnimation forKey:@"WhatEverNameYouWant"];
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
    static  NSString * reuseIdentifier=@"resueIdentifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];

    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
     
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text=_titles[indexPath.row];
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *controller=_controllers[indexPath.row];
    Class class=NSClassFromString(controller);
    
    id obj=[class new];
    
    [self.navigationController pushViewController:obj animated:YES];

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
