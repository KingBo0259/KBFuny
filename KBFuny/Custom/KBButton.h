//
//  KBButton.h
//  KBFuny
//
//  Created by jinlb on 15/2/28.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBButton : UIButton

@property (nonatomic, copy) NSString *name;
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
- (UIColor *)backgroundColorForState:(UIControlState)state;
@end