//
//  KBPopoerView.h
//  KBFuny
//
//  Created by jinlb on 15/6/30.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBPopoverView : UIView{
}


@property (nonatomic,strong)UIView* contextView;


+(KBPopoverView*)showPopoverWithFrame:(CGRect)frame
                     WithContextView:(UIView*)contextView;
@end
