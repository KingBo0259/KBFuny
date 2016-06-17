//
//  KBBadgeView.h
//  KBFuny
//
//  Created by jinlb on 15/3/27.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBBadgeView : UIView
{

    UILabel *_numberLable;
    NSInteger *_bageNumber;
}
@property (nonatomic,assign) NSInteger badgeNumber;
@end
