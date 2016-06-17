//
//  KBTouchTableView.h
//  KBFuny
//
//  Created by jinlb on 15/10/16.
//  Copyright © 2015年 jinlb. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TouchTableViewDelegate <NSObject>
@optional
 - (void)tableView:(UITableView *)tableView touchesBegin:(NSSet *)touches withEvent:(UIEvent *)event;
 - (void)tableView:(UITableView *)tableView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
 - (void)tableView:(UITableView *)tableView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
 - (void)tableView:(UITableView *)tableView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
 @end

@interface KBTouchTableView : UITableView

@property(weak,nonatomic)id<TouchTableViewDelegate> touchTableViewDelegate;
@end
