//
//  KCCoreDataTVC.h
//  KBFuny
//
//  Created by jinlb on 16/5/3.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBCoreDataMananger.h"


@interface KCCoreDataTVC : UITableViewController<NSFetchedResultsControllerDelegate>
@property(strong,nonatomic)NSFetchedResultsController *frc;

-(void)performFetch;
@end
