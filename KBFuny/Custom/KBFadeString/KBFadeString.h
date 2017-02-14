//
//  KBFadeString.h
//  KBFuny
//
//  Created by jinlb on 2017/2/14.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBFadeString : UIView
//输入文字
@property(nonatomic,strong) NSString *text;


/**
 向右渐变消失
 */
-(void)fadeRight;
@end
