//
//  KBRefreshViewController.h
//  KBFuny
//
//  Created by jinlb on 15/12/2.
//  Copyright © 2015年 jinlb. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* const KBRefreshViewControlStr;//定义全局的静态变量


@interface KBRefreshViewController : UIViewController

@property(nonatomic,getter=isON) BOOL on;

///ISOn
-(BOOL)isON;
@end
